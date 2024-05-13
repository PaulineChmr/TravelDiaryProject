//
//  CDImage+CoreDataProperties.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 13/5/2024.
//
//

import Foundation
import CoreData


extension CDImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImage> {
        return NSFetchRequest<CDImage>(entityName: "CDImage")
    }

    @NSManaged public var imagePath: String?
    @NSManaged public var imageid: UUID?
    @NSManaged public var position: Int16
    @NSManaged public var day: CDDay?

}

extension CDImage : Identifiable {

}
