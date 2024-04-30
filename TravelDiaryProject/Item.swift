//
//  Item.swift
//  TravelDiaryProject
//
//  Created by Sidak Singh Aulakh on 30/4/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
