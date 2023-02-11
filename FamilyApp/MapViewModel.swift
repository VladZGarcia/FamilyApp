//
//  MapViewModel.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//
import MapKit
import Firebase

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 59.314278,
                                                         longitude: 18.023720)
    static  let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01,
                                               longitudeDelta: 0.01)
}
 class MapContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
     
     @Published var region = MKCoordinateRegion(center:MapDetails.startingLocation,
                                                span: MapDetails.defaultSpan )
     @Published var userLocation = [Place]()
     let db = Firestore.firestore()
     var manager = CLLocationManager()
     var location : CLLocationCoordinate2D?
     
     override init() {
         super.init()
         manager.delegate = self
     }
    func startLocationUpdates() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        if let location = manager.location{
            saveToFirestore(userName: "user1", userLatitude: (location.coordinate.latitude), userLongitude: (location.coordinate.longitude))
       
        }
        //if CLLocationManager.locationServicesEnabled() {
      //
      //      locationManager = CLLocationManager()
      //      if locationManager != nil {
        
      //      }
      //
      //      //locationManager?.desiredAccuracy = kCLLocationAccuracyBest
      //  } else {
      //      locationManager?.requestWhenInUseAuthorization()
      //      print("Show an alert lettin them know its off, go turn it on")
      //  }
    }
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let location = locations.first?.coordinate {
             updateLocationInFirestore(userLatitude: location.latitude, userLongitude: location.longitude)
             print("Plats uppdaterad \(location)")
             
         }
         
     }
    
   // private func checkLocationAuthorization() {
   //     //let db = Firestore.firestore()
   //
   //     guard let locationManager = locationManager else {
   //         return
   //     }
   //     switch locationManager.authorizationStatus {
   //
   //     case .notDetermined:
   //         locationManager.requestWhenInUseAuthorization()
   //     case .restricted:
   //         print("Your location is restricted see parental controls.")
   //     case .denied:
   //         print("You have denied this app location permission. Go to settings.")
   //     case .authorizedAlways, .authorizedWhenInUse:
   //         print("userAutherized!!!!!!!!!!!!!!!!!!!")
   //         region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
   //
   //     @unknown default:
   //         break
   //     }
   // }
   //
   // func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
   //     checkLocationAuthorization()
   // }
     
     func saveToFirestore(userName: String, userLatitude: Double, userLongitude: Double) {
         let place = Place(name: userName, latitude: userLatitude, longitude: userLongitude)
         
        
             do {
                 //_ = try db.collection("location").document().delete()
                 _ = try db.collection("location").addDocument(from: place)
             } catch {
                 print("Error savin to DB")
             }
         }
     
     func updateLocationInFirestore(userLatitude: Double, userLongitude: Double) {
         db.collection("location").addSnapshotListener { [self] snapshot, err in
             guard let snapshot = snapshot else {return}
             if let err = err {
                 print("error getting document \(err)")
             } else {
                 userLocation.removeAll()
                 for document in snapshot.documents {
                     let result = Result {
                         try document.data(as: Place.self)
                     }
                     switch result {
                     case.success(let place) :
                         userLocation.append(place)
       
                     case .failure(let error) :
                         print("Error decoding item: \(error)")
                     }
                 }
             }
         }
         for user in userLocation {
             if let id = user.id {
                 db.collection("location").document(id).updateData(["latitude": userLatitude, "longitude": userLongitude])
                 print("Plats uppdaterad i Firebase \(user.coordinate)")
             }
             
             
         }
         
         
     }
     
}
