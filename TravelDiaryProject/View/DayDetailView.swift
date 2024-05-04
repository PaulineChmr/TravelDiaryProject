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
    var body: some View {
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
                    Text(day.descr ?? "")
                }
            }.navigationTitle(Text(day.date!, style: .date))
        }
    }
    
    private func getImage() -> UIImage? {
        if let imagePath = day.image,
           let uiImage = UIImage(contentsOfFile: imagePath){
            return uiImage
        }
        else{
            return UIImage(named: "imagenotfound.jpeg")
        }
    }
}
