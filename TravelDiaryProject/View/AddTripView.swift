//
//  AddTripView.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//

import Foundation
import SwiftUI

struct AddTripView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedImage: UIImage?
    @State private var imagePath: String?
    @State private var showImagePicker: Bool = false
    @State private var errorMessage: String = "Please fill completely the form"
    @State private var showAlert: Bool = false
    @State private var shouldNavigate: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Start date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End date", selection: $endDate, displayedComponents: .date)
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
                        MonoImagePicker(selectedImage: $selectedImage, imagePath: $imagePath)
                    }
                }
                
                Button(action: saveTrip){
                    Text("Save trip")
                }
                if showAlert{
                    Text(errorMessage).foregroundStyle(.red)
                }
            }
            .navigationTitle("New Trip")
            .sheet(isPresented: $showImagePicker) {
                MonoImagePicker(selectedImage: $selectedImage, imagePath: $imagePath)
            }
        }.navigationDestination(isPresented: $shouldNavigate) {
            HomeView()
        }
    }
    
    private func saveTrip() {
        guard selectedImage != nil else {
            showAlert = true
            return
        }
        let newTrip = CDTrip(context: viewContext)
        newTrip.id = UUID()
        newTrip.title = self.title
        newTrip.descr = self.description
        newTrip.startDate = self.startDate
        newTrip.endDate = self.endDate
        newTrip.image = self.imagePath
        newTrip.days = createDaysTrip()
        shouldNavigate = true
        do{
            try viewContext.save()
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func createDaysTrip() -> NSSet{
        var dayArray: [CDDay] = []
        var currentDate = self.startDate
        while currentDate <= endDate{
            let day = CDDay(context: viewContext)
            day.id = UUID()
            day.descr = ""
            day.date = currentDate
            day.edited = false
            day.images = []
            guard let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else{
                break
            }
            dayArray.append(day)
            currentDate = nextDate
        }
        return Set(dayArray) as NSSet
    }
}

struct AddTripView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripView()
    }
}
