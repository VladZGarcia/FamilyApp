//
//  Map.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI
import MapKit

struct MapContentView: View {
    @StateObject private var viewModel = MapContentViewModel()
    
    @State private var region = MKCoordinateRegion(center:
                                                    CLLocationCoordinate2D(latitude: 59.314278,
                                                                           longitude: 18.023720), span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                                longitudeDelta: 0.01))
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
    }
}

final class MapContentViewModel: ObservableObject {
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationSercicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            
        } else {
            print("Show an alert lettin them know its off, go turn it on")
        }
    }
    
    func checklocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted see parental controls.")
        case .denied:
            print("You have denied this app location permission. Go to settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}
