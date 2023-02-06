//
//  Map.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI
import MapKit
import Firebase

struct MapContentView: View {
    @StateObject private var viewModel = MapContentViewModel()
    let db = Firestore.firestore()
    @State var places = [Place(name: "Nice place", latitude: 37.3323341, longitude: -122.032)]
    var locationManager = CLLocationManager()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            interactionModes: [.all],
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: places) { place in
            MapAnnotation(coordinate: place.coordinate) {
                VStack(spacing: 0){
                    ZStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                        //.resizable()
                            .foregroundColor(.white)
                            .frame(width: 54, height: 54)
                            .shadow(radius: 2, x: 2, y: 2)
                            .background(.blue)
                            .clipShape(Circle())
                        
                        Image("hund")
                            .resizable()
                            .frame(width: 44, height: 44, alignment: .center)
                            .clipShape(Circle())
                    }
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .offset(x: 0, y: -3)
                    Text(place.name)
                }
            }
            
        }
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.startLocationUpdates()
               
            }
        
    }
    
}
    //func saveToFirestore(userName: String, userLatitude: Double, userLongitude: Double) {
    //    let place = Place(name: userName, latitude: userLatitude, longitude: userLongitude)
    //
    //    do {
    //        _ = try db.collection("location").addDocument(from: place)
    //    } catch {
    //        print("Error savin to DB")
    //    }
    //}
    


