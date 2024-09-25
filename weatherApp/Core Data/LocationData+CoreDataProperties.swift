//
//  LocationData+CoreDataProperties.swift
//  weatherApp
//
//  Created by SID on 25/09/2024.
//
//

import Foundation
import CoreData


extension LocationData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationData> {
        return NSFetchRequest<LocationData>(entityName: "LocationData")
    }

    @NSManaged public var locationName: String?
    @NSManaged public var weatherDescrip: String?
    @NSManaged public var windSpeed: String?
    @NSManaged public var humidity: String?
    @NSManaged public var pressure: String?
    @NSManaged public var visibility: String?

}

extension LocationData : Identifiable {

}
