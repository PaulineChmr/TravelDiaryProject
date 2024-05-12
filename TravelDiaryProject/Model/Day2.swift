//
//  DayTrip.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 1/5/2024.
//

import Foundation
import UIKit

class DayTrip2{
    var dayId: UUID = UUID()
    var images: [UIImage] = []
    var description: String = ""
    var date: Date
    var edited: Bool
    
    init(dayId: Int, images: [UIImage], description: String, date: Date, edited: Bool) {
        self.dayId = UUID()
        self.images = images
        self.description = description
        self.date = date
        self.edited = edited
    }
}
