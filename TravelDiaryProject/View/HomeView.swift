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
    
    var body: some View{
        NavigationStack{
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
                Button(action: {
                    deleteTrip(trip: trip)
                }, label: {
                    Label("", systemImage: "xmark.circle").foregroundColor(.red)
                })
            }
            .navigationTitle("My trips")
            .navigationBarItems(trailing: addButton)
        }.navigationBarBackButtonHidden(true)
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
        }
    }
}
