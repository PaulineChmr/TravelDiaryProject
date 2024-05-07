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
    @State private var image: [String] = []
    @State private var selectedImages: [UIImage] = []
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
                    if !selectedImages.isEmpty {
                        ForEach(selectedImages.indices, id: \.self){ index in
                            Image(uiImage: selectedImages[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                        }
                    }
                    Button(action: {
                        showImagePicker = true
                    }) {
                        
                        Text("Add a picture")
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImages, imagePath: $image)
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
                ImagePicker(selectedImage: $selectedImages, imagePath: $image)
            }
        }.navigationDestination(isPresented: $shouldNavigate) {
            TripDetailView(trip: trip!)
        }
    }
    
    private func saveDay() {
        guard selectedImages != [] else {
            showAlert = true
            return
        }
        let newDay = CDDay(context: viewContext)
        newDay.id = self.id
        newDay.descr = self.descr
        newDay.date = self.date
        newDay.images = createImagesDay()
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
    
    private func createImagesDay() -> NSSet{
        var imagesArray: [CDImage] = []
        var index: Int = 0
        for image in self.image{
            let imageToSave = CDImage(context: viewContext)
            imageToSave.imageid = UUID()
            imageToSave.imagePath = image
            imageToSave.position = Int16(index)
            index += 1
            imagesArray.append(imageToSave)
        }
        return Set(imagesArray) as NSSet
    }
}
