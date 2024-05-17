//
//  MapView.swift
//  TravelDiaryProject
//
//  Created by Sidak Singh Aulakh on 17/5/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var latitude: Double
    @State var longitude: Double
    @State var date: Date
    var body: some View {
        Map {
//            Marker("Empire state building", coordinate: .empireStateBuilding)
//                .tint(.orange)
            Annotation("empireStateBuilding", coordinate: CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.teal)
                    Text("🎓")
                        .padding(5)
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
            MapPitchToggle()
        }
        .mapStyle(.hybrid(elevation: .realistic))
    }
}

#Preview {
    MapView(latitude: 40.7063, longitude: -74.1973, date: Date())
}

extension CLLocationCoordinate2D {
    static let weequahicPark = CLLocationCoordinate2D(latitude: 40.7063, longitude: -74.1973)
    static let empireStateBuilding = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
    static let columbiaUniversity = CLLocationCoordinate2D(latitude: 40.8075, longitude: -73.9626)
}
