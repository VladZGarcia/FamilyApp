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
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    let db = Firestore.firestore()
    var locationManager = CLLocationManager()
    
    var body: some View {
        Map(coordinateRegion: $mapViewModel.region,
            interactionModes: [.all],
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: mapViewModel.userLocation) { user in
            MapAnnotation(coordinate: user.coordinate) {
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
                    Text(user.name)
                }
            }
            
        }
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                mapViewModel.startLocationUpdates()
               
            }
    }
    
}
struct MapContentView_Previews: PreviewProvider {
static var previews: some View {
    MapContentView()
}
}
