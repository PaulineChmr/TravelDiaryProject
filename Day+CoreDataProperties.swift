//
//  Day+CoreDataProperties.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var descr: String?
    @NSManaged public var date: Date?
    @NSManaged public var edited: Bool

}

extension Day : Identifiable {

}
