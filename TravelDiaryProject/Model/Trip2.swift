//
//  Trip.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 1/5/2024.
//

import Foundation
import UIKit

class Trip2: Identifiable{
    var tripId: UUID = UUID()
    var title: String = ""
    var description: String = ""
    var descriptionPhoto: UIImage
    var startDate: Date
    var endDate: Date
    var days: [DayTrip2] = []
    
    init(title: String, description: String, descriptionPhoto: UIImage, startDate: Date, endDate: Date, days: [DayTrip2]) {
        self.tripId = UUID()
        self.title = title
        self.description = description
        self.descriptionPhoto = descriptionPhoto
        self.startDate = startDate
        self.endDate = endDate
        self.days = days
    }
}
