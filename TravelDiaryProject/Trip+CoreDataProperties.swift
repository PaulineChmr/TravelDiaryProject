//
//  Trip+CoreDataProperties.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var descr: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?

}

extension Trip : Identifiable {

}
