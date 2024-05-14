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
        HStack{
                    NavigationLink{
                        HomeView()
                    } label: {
                        Label("Back", systemImage: "arrow.left.circle")
                    }
                    Spacer()
                }
        NavigationView {
            // If users write a long test in the description section, it allows users to scroll down the screen.
            ScrollView{
                //Using VStack instead of form to modify the styles. There are many limitation of using form.
                VStack(spacing: 20) {
                    HStack{
                        Text("Add your new trip")
                            .font(.custom("Roboto-Regular", size: 18)) // Customize your font here
                            .foregroundColor(.tdTextBody)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.init(top: 35, leading: 20, bottom: 30, trailing: 0))
                       
                    }
                    Section(header: Text("").font(.custom("Roboto-Regular", size: 20)).foregroundColor(.tdTextTitle)) {
                        VStack{
                            TextField("Title", text: $title)
                                .foregroundColor(.tdPurple)
                                .font(.custom("Roboto-Black", size: 28))
                                .padding(.init(top: 30, leading: 20, bottom: 5, trailing: 20))
                            TextField("Description", text: $description)
                                .foregroundColor(.tdTextTitle)
                                .font(.custom("Roboto-Medium", size: 20))
                                .padding(.init(top: 5, leading: 20, bottom: 10, trailing: 20))
                            HStack{
                                Text("Start Date")
                                    .foregroundColor(.tdTextTitle)
                                    .font(.custom("Roboto-Regular", size: 17))
                                    .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                                DatePicker("", selection: $startDate, displayedComponents: .date)
                                    .accentColor(.tdRedorange)
                                    .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                            }
                            HStack{
                                Text("End Date")
                                    .foregroundColor(.tdTextTitle)
                                    .font(.custom("Roboto-Regular", size: 17))
                                    .padding(.init(top: 5, leading: 20, bottom: 30, trailing: 20))
                                DatePicker("", selection: $endDate, displayedComponents: .date)
                                    .accentColor(.tdRedorange)
                                    .padding(.init(top: 5, leading: 20, bottom: 30, trailing: 20))
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(20)  // Rounded corners
                        .shadow(color: .gray, radius: 5, x: 3, y: 3)
                        .padding(.horizontal)
                    }
                    
                    Section() {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                            } else {
                                Text("Add your photo")
                            }
                        }
                        .frame(width: 320)
                        .padding(15)
                        .background(.white)
                        .foregroundColor(.tdRedorange)
                        .font(.custom("Roboto-Regular", size: 17))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .gray, radius: 5, x: 3, y: 3)
                        .sheet(isPresented: $showImagePicker) {
                            MonoImagePicker(selectedImage: $selectedImage, imagePath: $imagePath)
                        }
                    }
                   
                    
                    Spacer()
                        .frame(height: 30)
                    Button(action: saveTrip){
                        Text("Save trip")
                    }
                    .frame(width: 300)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(10)
                    .background(.tdRedorange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    if showAlert{
                        Text(errorMessage).foregroundStyle(.red)
                    }
                }
            }
            .background(Color.tdBeige) // Set the background color of ScrollView to blue.
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack{
                        Spacer()
                            .frame(height:60)
                        HStack{
                            Text("New Trip")
                                .font(.custom("Roboto-Black", size: 43)) // Customize your font here
                                .foregroundColor(.tdRedorange)
                            Image(systemName: "pencil.line")
                                .font(.system(size: 30))
                                .foregroundColor(.tdTextBody)
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                MonoImagePicker(selectedImage: $selectedImage, imagePath: $imagePath)
            }
        }.navigationDestination(isPresented: $shouldNavigate) {
            HomeView()
        }
        .navigationBarBackButtonHidden()

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
