import Flutter
import Foundation
import CoreLocation

public class GeofencingApplePlugin: NSObject, FlutterPlugin {
    static let geofencingMethodChannelName = "yak.digital/geofencing_apple"
    static let monitorMethodChannelName = "yak.digital/geofencing_monitor_apple"
    var geofencingHandler: HandlerProtocol?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: self.geofencingMethodChannelName, binaryMessenger: registrar.messenger())
        let instance = GeofencingApplePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let monitorEventChannel: FlutterEventChannel = FlutterEventChannel(name: self.monitorMethodChannelName, binaryMessenger: registrar.messenger())
        if #available(iOS 17.0, *) {
            let monitorHandler = MonitorHandler()
            instance.geofencingHandler = monitorHandler
            monitorEventChannel.setStreamHandler(monitorHandler)
        } else {
            let locationManagerHandler = LocationManagerHandler()
            instance.geofencingHandler = locationManagerHandler
            monitorEventChannel.setStreamHandler(locationManagerHandler)
        }
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "isRegionMonitoringAvailable":
                onIsRegionMonitoringAvailable(withArgument: call.arguments, result: result)
            case "startMonitoringForRegion":
                onStartMonitoringForRegion(withArgument: call.arguments as? Dictionary<String, Any>, result: result)
            case "stopMonitoringForRegion":
                onStopMonitoringForRegion(withArgument: call.arguments, result: result)
            case "getMonitoredRegions":
                onGetMonitoredRegions(withArgument: call.arguments, result: result)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
    
    func onIsRegionMonitoringAvailable(withArgument arguments: Any?, result: FlutterResult) {
        let available: Bool = geofencingHandler!.isRegionMonitoringAvailable();
        result(available)
    }
    
    func onStartMonitoringForRegion(withArgument arguments: Dictionary<String, Any>?, result: FlutterResult) {
        let region = Region.fromMap(arguments!["region"] as! Dictionary<String, Any>)
        geofencingHandler?.startMonitoring(forRegion: region)
        result(nil)
    }
    
    func onStopMonitoringForRegion(withArgument arguments: Any?, result: FlutterResult) {
        let argumentsDict = arguments as! Dictionary<String, Any>
        let region = Region.fromMap(argumentsDict["region"] as! Dictionary<String, Any>)
        geofencingHandler?.stopMonitoring(forRegion: region)
        result(nil)
    }
    
    func onGetMonitoredRegions(withArgument arguments: Any?, result: @escaping FlutterResult) {
        Task {
            let results: NSMutableArray = []
            let regions = await geofencingHandler!.getMonitoredRegions()
            for region in regions {
                results.add(region.toMap())
            }
            result(results)
        }
    }
}
