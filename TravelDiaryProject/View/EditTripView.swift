//
//  EditTripView.swift
//  TravelDiaryProject
//
//  Created by Sidak Singh Aulakh on 13/5/2024.
//

import SwiftUI

struct EditTripView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var trip: CDTrip
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedImage: UIImage?
    @State private var imagePath: String?
    @State private var showImagePicker: Bool = false
    @State private var errorMessage: String = "Please fill the form completely"
    @State private var showAlert: Bool = false
    @State private var shouldNavigate: Bool = false
    
    var body: some View {
        HStack{
            NavigationLink{
                HomeView()
            } label: {
                Label("Back", systemImage: "arrow.left.circle")
            }
            Spacer()
        }
        NavigationView {
            Form {
                Section(header: Text("Edit trip information")) {
                    TextField("Title", text: Binding(get: {trip.title ?? ""}, set: {trip.title = $0}))
                    TextField("Description", text: Binding(get: {trip.descr ?? ""}, set: {trip.descr = $0}))
                    DatePicker("Start date", selection: Binding(get: {trip.startDate ?? Date()}, set: {trip.startDate = $0}), displayedComponents: .date)
                    DatePicker("End date", selection: Binding(get: {trip.endDate ?? Date()}, set: {trip.startDate = $0}), displayedComponents: .date)
                }
                
                Section(header: Text("Choose another Picture")) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                        } else {
                            Text("Edit trip photo")
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        MonoImagePicker(selectedImage: $selectedImage, imagePath: $imagePath)
                    }
                }
                
                Button(action: saveTrip){
                    Text("Update trip")
                }
            }
            .navigationTitle("Edit Trip")
        }.navigationDestination(isPresented: $shouldNavigate) {
            TripDetailView(trip: trip)
        }.navigationBarBackButtonHidden()
        
    }
    private func saveTrip() {
        guard selectedImage != nil else {
            showAlert = true
            return
        }
        trip.days = createDaysTrip()
        trip.image = self.imagePath
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

//#Preview {
//    EditTripView(trip: CDTrip())
//}
