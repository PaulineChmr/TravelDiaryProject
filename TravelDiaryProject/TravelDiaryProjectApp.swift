//
//  TravelDiaryProjectApp.swift
//  TravelDiaryProject
//
//  Created by Sidak Singh Aulakh on 30/4/2024.
//

import SwiftUI
import SwiftData

@main
struct TravelDiaryProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            HomeView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
