//
//  CDDay+CoreDataProperties.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 7/5/2024.
//
//

import Foundation
import CoreData


extension CDDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDay> {
        return NSFetchRequest<CDDay>(entityName: "CDDay")
    }

    @NSManaged public var date: Date?
    @NSManaged public var descr: String?
    @NSManaged public var edited: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var trip: CDTrip?
    @NSManaged public var images: NSSet?
    
    public var imageArray: [CDImage]{
        let set = images as? Set<CDImage> ?? []
        return set.sorted{
            $0.position  < $1.position
        }
    }

}

// MARK: Generated accessors for images
extension CDDay {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: CDImage)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: CDImage)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension CDDay : Identifiable {

}
