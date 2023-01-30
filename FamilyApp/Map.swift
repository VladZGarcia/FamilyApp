//
//  Map.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI
import MapKit

struct MapContentView: View {
    @State private var region = MKCoordinateRegion(center:
                                                    CLLocationCoordinate2D(latitude: 59.314278,
                                                                           longitude: 18.023720), span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                                longitudeDelta: 0.01))
    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
    }
}

