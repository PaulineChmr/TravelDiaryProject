//
//  CDDay+CoreDataProperties.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//
//

import Foundation
import CoreData


extension CDDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDay> {
        return NSFetchRequest<CDDay>(entityName: "CDDay")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var descr: String?
    @NSManaged public var date: Date?
    @NSManaged public var edited: Bool
    @NSManaged public var image: String?
    @NSManaged public var trip: CDTrip?

}

extension CDDay : Identifiable {

}
