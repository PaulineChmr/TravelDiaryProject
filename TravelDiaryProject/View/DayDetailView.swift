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
        ScrollView{
            NavigationStack{
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(images.indices, id: \.self){ index in
                        Image(uiImage: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    Text("Description")
                        .font(.title2)
                    Text(day.descr ?? "")
                }
            }.navigationTitle(Text(day.date!, style: .date))
        }.onAppear{
            getImage()}
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
