//
//  CDTrip+CoreDataProperties.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//
//

import Foundation
import CoreData


extension CDTrip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTrip> {
        return NSFetchRequest<CDTrip>(entityName: "CDTrip")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var descr: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var image: String?
    @NSManaged public var days: NSSet?
    
    public var dayArray: [CDDay]{
        let set = days as? Set<CDDay> ?? []
        return set.sorted{
            $0.date!  < $1.date!
        }
    }

}

// MARK: Generated accessors for days
extension CDTrip {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: CDDay)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: CDDay)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}

extension CDTrip : Identifiable {

}
