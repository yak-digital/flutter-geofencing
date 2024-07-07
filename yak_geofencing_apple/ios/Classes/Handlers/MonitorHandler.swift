import Flutter
import CoreLocation

@available(iOS 17, *)
class MonitorHandler: NSObject, FlutterStreamHandler, HandlerProtocol {
    let monitorName = "GeofencingApplePlugin"
    public var monitor: CLMonitor?
    var eventSink: FlutterEventSink?
    var eventTask: Task<(), Error>?

    override init() {
        super.init()
        Task {
            monitor = await CLMonitor(monitorName)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        if eventSink != nil {
            return FlutterError(code: Errors.geofencingSubscriptionActive, message: Errors.geofencingSubscriptionActiveMessage, details: nil);
        }
        
        eventSink = events
        eventTask = Task {
            for try await event: CLMonitor.Events.Element in await monitor!.events {
                guard eventSink == nil else {
                    let condition = await self.monitor!.record(for: event.identifier)?.condition as! CLMonitor.CircularGeographicCondition
                    let region = Region.fromCircularGeographicCondition(condition, withIdentifier: event.identifier)
                    var dict: [String: Any] = [
                        "region": region.toMap(),
                    ];
                    
                    switch (event.state) {
                        case .satisfied:
                            dict["type"] = "enter"
                        case .unsatisfied:
                            dict["type"] = "exit"
                        case .unknown:
                            NSLog("\(event.identifier) is unknown")
                            dict["type"] = "unknown"
                        case .unmonitored:
                            NSLog("\(event.identifier) is unmonitored")
                            dict["type"] = "unmotitored"
                        default:
                            NSLog("\(event.identifier) is not supported")
                            dict["type"] = "not_supported"
                    }
                    await self.handleEvent(dict)
                    continue
                }
            }
        }
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventTask?.cancel()
        eventSink = nil
        return nil
    }
    
    @MainActor
    public func handleEvent(_ event: Dictionary<String, Any>) {
        eventSink?(event)
    }

    func isRegionMonitoringAvailable() -> Bool {
        return true
    }

    func startMonitoring(forRegion region: Region) {
        Task {
            let center = CLLocationCoordinate2D(latitude: region.latitude, longitude: region.longitude)
            let condition = CLMonitor.CircularGeographicCondition(center: center, radius: region.radius)
            await monitor!.add(condition, identifier: region.identifier, assuming: .unsatisfied)
        }
    }

    func stopMonitoring(forRegion region: Region) {
        Task {
            await monitor!.remove(region.identifier)
        }
    }
    
    func getMonitoredRegions() async -> Set<Region> {
        var regions = Set<Region>()
        let identifiers = await self.monitor!.identifiers
        for identifier in identifiers {
            let condition = await self.monitor!.record(for: identifier)?.condition as! CLMonitor.CircularGeographicCondition
            let region = Region.fromCircularGeographicCondition(condition, withIdentifier: identifier)
            regions.insert(region)
        }
        return regions
    }
}
