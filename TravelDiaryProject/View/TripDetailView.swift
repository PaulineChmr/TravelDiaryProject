//
//  TripDetailView.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 1/5/2024.
//

import Foundation

import SwiftUI

struct TripDetailView: View{
    var trip: CDTrip
    var body: some View{
        HStack{
            NavigationLink{
                HomeView()
            } label: {
                Label("Back", systemImage: "arrow.left.circle")
            }
            Spacer()
        }
        ScrollView{
            NavigationStack{
                VStack(alignment: .leading, spacing: 20) {
                    if let uiImage = getImage(){
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    Text("Description")
                        .font(.title2)
                    Text(trip.descr ?? "")
                    Spacer()
                    Text("Day details")
                        .font(.title2)
                    ForEach(trip.dayArray, id: \.self){ day in
                        NavigationLink{
                            if(day.edited){
                                DayDetailView(day: day)
                            }
                            else{
                                AddDayView(day: day, id: day.id, date: day.date!, trip: day.trip)
                            }
                        } label: {
                            Text(day.date!, style: .date)
                        }
                    }
                }
            }.navigationTitle(trip.title ?? "Trip details")
            .navigationBarBackButtonHidden()
        }
    }
    
    private func getImage() -> UIImage? {
        if let imagePath = trip.image,
           let uiImage = UIImage(contentsOfFile: imagePath){
            return uiImage
        }
        else{
            return UIImage(named: "imagenotfound.jpeg")
        }
    }
}
