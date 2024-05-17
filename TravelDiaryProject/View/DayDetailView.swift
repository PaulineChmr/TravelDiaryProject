//
//  DayView.swift
//  TravelDiaryProject
//
//  Created by Pauline Chaumeron on 4/5/2024.
//

import Foundation
import SwiftUI

struct DayDetailView: View{
    @State var day: CDDay
    @State var images: [UIImage] = []
    var body: some View {
        HStack{
                    NavigationLink{
                        TripDetailView(trip: day.trip!)
                    } label: {
                        Label("Back", systemImage: "arrow.left.circle")
                    }
                    Spacer()
        ScrollView{
            NavigationStack{
                TabView{
                                    ForEach(images.indices, id: \.self){ index in
                                        Image(uiImage: images[index])
                                            .resizable()
                                            .scaledToFit()
                                    }
                                }.tabViewStyle( .page(indexDisplayMode: .always))
                                    .frame(height: 250)
                    Text("Description")
                        .font(.title2)
                    Text(day.descr ?? "")
                NavigationLink{
                    MapView(latitude: day.locationLatitude, longitude: day.locationLongitude, date: day.date ?? Date())
                } label: {
                    Text("See Location")
                }
                }
            }.navigationTitle(Text(day.date!, style: .date))
        }.onAppear{
            getImage()}
        .navigationBarBackButtonHidden()
    }
    
    private func getImage() {
        if day.imageArray.count != 0{
            for image in day.imageArray{
                self.images.append((UIImage(contentsOfFile: image.imagePath!) ?? UIImage(named: "imagenotfound.jpeg"))!)
            }
        }
        else{
            self.images.append(UIImage(named: "imagenotfound.jpeg")!)
        }
    }
}
