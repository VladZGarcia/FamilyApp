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
    @EnvironmentObject var mapViewModel : MapContentViewModel
    //@EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject var viewModel : AppViewModel
    
    let db = Firestore.firestore()
    //var locationManager = CLLocationManager()
    
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
                            //.background(.blue)
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
            //.ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                print("in mapContentView mapGroupCode: \(mapViewModel.mapGroupCode)")
                if viewModel.haveUserData {
                    mapViewModel.mapUserId = viewModel.userId
                    mapViewModel.mapGroupCode = viewModel.groupCode
                    viewModel.haveDataForDB = true
                }
                if viewModel.haveDataForDB {
                    print("in mapContentView mapGroupCode: \(mapViewModel.mapGroupCode)")
                    mapViewModel.startLocationUpdates()
                    mapViewModel.listenToFirestore()
                }
            }
    }
    
}
struct MapContentView_Previews: PreviewProvider {
static var previews: some View {
    MapContentView()
        .environmentObject(AppViewModel())
        
}
}
