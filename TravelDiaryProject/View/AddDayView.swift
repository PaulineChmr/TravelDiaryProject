//
//  AddDayView.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//

import Foundation
import SwiftUI

struct AddDayView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @State var day: CDDay
    @State var id: UUID?
    @State private var descr: String = ""
    @State var date: Date
    @State private var image: String? = ""
    @State private var selectedImage: UIImage?
    @State var trip: CDTrip?
    @State private var showImagePicker: Bool = false
    @State private var errorMessage: String = "Please fill completely the form"
    @State private var showAlert: Bool = false
    @State private var shouldNavigate: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations")) {
                    TextField("Description", text: $descr)
                }
                
                Section(header: Text("Picture")) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                        } else {
                            Text("Ajouter une Photo")
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage, imagePath: $image)
                    }
                }
                
                Section{
                    Button(action: saveDay){
                        Text("Save day")
                    }
                }
                if showAlert{
                    Text(errorMessage).foregroundStyle(.red)
                }
            }
            .navigationTitle("New Trip")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage, imagePath: $image)
            }
        }.navigationDestination(isPresented: $shouldNavigate) {
            TripDetailView(trip: trip!)
        }
    }
    
    private func saveDay() {
        guard selectedImage != nil else {
            showAlert = true
            return
        }
        let newDay = CDDay(context: viewContext)
        newDay.id = self.id
        newDay.descr = self.descr
        newDay.date = self.date
        newDay.image = self.image
        newDay.trip = self.trip
        newDay.edited = true
        shouldNavigate = true
        trip?.removeFromDays(day)
        trip?.addToDays(newDay)
        do{
            try viewContext.save()
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
