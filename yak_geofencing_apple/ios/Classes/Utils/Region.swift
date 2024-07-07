//
//  Region.swift
//  geofencing_apple
//
//  Created by Tim Kandel on 06.07.24.
//

import Foundation
import CoreLocation

struct Region: Hashable {
    var identifier: String
    var latitude: Double
    var longitude: Double
    var radius: Double
    var notifyOnEntry: Bool = true
    var notifyOnExit: Bool = true
    
    // todo: handle errors in dict
    static func fromMap(_ regionMap: Dictionary<String, Any>) -> Region {
        let identifier: String = regionMap["identifier"] as! String
        let latitude: Double = regionMap["latitude"] as! Double
        let longitude: Double = regionMap["longitude"] as! Double
        let radius: Double = regionMap["radius"] as! Double
        let notifyOnEntry: Bool = regionMap["notifyOnEntry"] as! Bool
        let notifyOnExit: Bool = regionMap["notifyOnExit"] as! Bool

        let region =  Region(identifier: identifier, latitude: latitude, longitude: longitude, radius: radius, notifyOnEntry: notifyOnEntry, notifyOnExit: notifyOnExit)
        return region
    }
    
    func toMap() -> Dictionary<String, Any> {
        return [
            "identifier": identifier,
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius,
            "notifyOnEntry": notifyOnEntry,
            "notifyOnExit": notifyOnExit,
        ];
    }
    
    @available(iOS 17, *)
    static func fromCircularGeographicCondition(_ condition: CLMonitor.CircularGeographicCondition, withIdentifier identifier: String) -> Region {
        let latitude: Double = condition.center.latitude
        let longitude: Double = condition.center.longitude
        let radius: Double = condition.radius
        
        let region = Region(identifier: identifier, latitude: latitude, longitude: longitude, radius: radius)
        return region
    }
}
