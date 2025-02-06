//
//  Plant+CoreDataProperties.swift
//  plantMonitor
//
//  Created by Yeabsera Damte on 11/22/24.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var name: String?
    @NSManaged public var wateringFrequency: Int16
    @NSManaged public var lastWatered: Date?

}

extension Plant : Identifiable {

}
