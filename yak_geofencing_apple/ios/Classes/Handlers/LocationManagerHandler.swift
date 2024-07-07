import Flutter
import CoreLocation

class LocationManagerHandler: NSObject, FlutterStreamHandler, CLLocationManagerDelegate, HandlerProtocol {
    public var locationManager: CLLocationManager?
    var eventSink: FlutterEventSink?

    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        if eventSink != nil {
            return FlutterError(code: Errors.geofencingSubscriptionActive, message: Errors.geofencingSubscriptionActiveMessage, details: nil);
        }
        
        eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    func isRegionMonitoringAvailable() -> Bool {
        CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
    }

    func startMonitoring(forRegion region: Region) {
        locationManager?.startMonitoring(for: regionToCircularRegion(region))
    }

    func stopMonitoring(forRegion region: Region) {
        locationManager?.stopMonitoring(for: regionToCircularRegion(region))
    }

    func getMonitoredRegions() async -> Set<Region> {
        let monitoredRegions = locationManager!.monitoredRegions
        var regions = Set<Region>()
        for monitoredRegion in monitoredRegions {
            if monitoredRegion is CLCircularRegion {
                let region = circularRegionToRegion(monitoredRegion as! CLCircularRegion)
                regions.insert(region)
            }
        }
        return regions
    }
    
    /*func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let dict: Dictionary<String, Any> = [
            "region": circularRegionToRegion(region as! CLCircularRegion).toMap(),
            "type": "enter",
        ]
        eventSink!(dict)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let dict: Dictionary<String, Any> = [
            "region": circularRegionToRegion(region as! CLCircularRegion).toMap(),
            "type": "exit",
        ]
        eventSink!(dict)
    }*/
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if (eventSink != nil) {
            var dict: Dictionary<String, Any> = [
                "region": circularRegionToRegion(region as! CLCircularRegion).toMap(),
            ]
            switch (state) {
                case .inside:
                    dict["type"] = "enter"
                case .outside:
                    dict["type"] = "exit"
                case .unknown:
                    dict["type"] = "unknown"
            }
            eventSink?(dict)
        }
    }
    
    func regionToCircularRegion(_ region: Region) -> CLCircularRegion {
        let circularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: region.latitude, longitude: region.longitude), radius: region.radius, identifier: region.identifier)
        circularRegion.notifyOnEntry = region.notifyOnEntry
        circularRegion.notifyOnExit = region.notifyOnExit
        return circularRegion
    }
    
    func circularRegionToRegion(_ circularRegion: CLCircularRegion) -> Region {
        return Region(identifier: circularRegion.identifier, latitude: circularRegion.center.latitude, longitude: circularRegion.center.longitude, radius: circularRegion.radius, notifyOnEntry: circularRegion.notifyOnEntry, notifyOnExit: circularRegion.notifyOnExit)
    }
}
