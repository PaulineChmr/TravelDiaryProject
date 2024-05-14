//
//  HomeView.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 1/5/2024.
//

import Foundation
import SwiftUI

struct HomeView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: CDTrip.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDTrip.startDate, ascending: true)]) private var trips: FetchedResults<CDTrip>
    @State private var isAppActive: Bool = false
    
    var body: some View{
        NavigationStack{
            // Before Application launches, showing a main image of application for 3 seconds.
            if isAppActive {
                List(trips){ trip in
                    NavigationLink{
                        TripDetailView(trip: trip)
                    } label: {
                        VStack{
                            if let imagePath = trip.image,
                               let uiImage = UIImage(contentsOfFile: imagePath){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                            }
                            else{
                                Image(uiImage: UIImage(named: "imagenotfound.jpeg")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            Text(trip.title ?? "")
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    Button(action: {
                        deleteTrip(trip: trip)
                    }, label: {
                        Label("", systemImage: "xmark.circle").foregroundColor(.red)
                    })
                }
                
                .listRowBackground(Color.clear)
                .background(Color.tdBeige)
                .listStyle(PlainListStyle())
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack{
                            Spacer()
                                .frame(height:60)
                            Text("My Trips")
                                .font(.custom("Roboto-Black", size: 43)) // Customize your font here
                                .foregroundColor(.tdRedorange)
                            Spacer()
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: addButton)
            } else {
                // Display a main image before launches the application.
                Image("mainAppImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Delay 3 seconds.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    isAppActive = true
                }
            }
        }
    }
    
    private func deleteTrip(trip: CDTrip){
        viewContext.delete(trip)
        do{
            try viewContext.save()
        } catch{
            print("Error while deleting the trip")
        }
    }
    var addButton: some View{
        NavigationLink{
            AddTripView()
        } label: {
                Label("", systemImage: "plus.app.fill")
                    .foregroundColor(.tdRedorange)
                    .font(.system(size: 24))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
