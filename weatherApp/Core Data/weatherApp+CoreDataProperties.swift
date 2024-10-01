//
//  weatherApp+CoreDataProperties.swift
//  weatherApp
//
//  Created by SID on 27/09/2024.
//
//

import Foundation
import CoreData


extension weatherApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<weatherApp> {
        return NSFetchRequest<weatherApp>(entityName: "weatherApp")
    }

    @NSManaged public var humidity: Int32
    @NSManaged public var locationName: String?
    @NSManaged public var pressure: Int32
    @NSManaged public var visibility: Int32
    @NSManaged public var weatherDescrip: String?
    @NSManaged public var windSpeed: String?

}

extension weatherApp : Identifiable {

}
