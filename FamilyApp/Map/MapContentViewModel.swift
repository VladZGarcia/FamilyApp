//
//  MapContentViewModel.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//
import MapKit
import Firebase
import SwiftUI

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 59.314278,
                                                         longitude: 18.023720)
    static  let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01,
                                               longitudeDelta: 0.01)
}
class MapContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //@EnvironmentObject  var familyGroupVM : FamilyGroupViewModel
    //@EnvironmentObject  var viewModel : AppViewModel
    
    @Published var region = MKCoordinateRegion(center:MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan )
    @Published var userLocation = [Users(latitude: 37.3323341, longitude: -122.029)]
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    var manager = CLLocationManager()
    var location : CLLocationCoordinate2D?
    @Published var userId = ""
    
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    func startLocationUpdates() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //if let location = manager.location{
        //    saveToFirestore(userName: "user1", userLatitude: (location.coordinate.latitude), userLongitude: //(location.coordinate.longitude))
        //
        //}
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
         location = locations.first?.coordinate
            
            print("Plats uppdaterad \(location)")
            
        
        
    }
    
    func listenToFirestore(groupCode: String) {
        db.collection("FamilyGroup")
            .document(groupCode)
            .collection("users")
            .addSnapshotListener { snapshot, err in
                //guard let snapshot = snapshot else {return}
                guard let snapshot = snapshot  else{
                    print("Data was empty.  \(err)")
                    return
                }
                if let err = err {
                    print("error getting document \(err)")
                } else {
                    self.userLocation.removeAll()
                    for document in snapshot.documents {
                        let result = Result{
                            try document.data(as: Users.self)
                        }
                        switch result {
                        case .success(let user) :
                            self.userLocation.append(user)
                        case .failure(let error) :
                            print("Error decoding item: \(error)")
                            
                        }
                        
                    }
                }
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
    
    //func saveToFirestore(userName: String, userLatitude: Double, userLongitude: Double) {
    //    let place = Place(name: userName, latitude: userLatitude, longitude: userLongitude)
    //
    //
    //        do {
    //            //_ = try db.collection("location").document().delete()
    //            _ = try db.collection("location").addDocument(from: place)
    //        } catch {
    //            print("Error savin to DB")
    //        }
    //    }
    
    func saveToFirestore(userGroupCode: String, userName: String) -> String? {
        let groupCode = userGroupCode
        guard let userEmail = auth.currentUser?.email else {return nil}
        //print("start of save to db UserID: \(viewModel.userId)")
        print("start of db userEmail: \(userEmail)")
        var ref: DocumentReference? = nil
        
        if let location = manager.location{
            let user = Users( name: userName, email: userEmail ,groupCode: groupCode, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            guard auth.currentUser != nil else {return nil}
            do {
                ref = try db.collection("FamilyGroup")
                    .document(groupCode)
                    .collection("users").addDocument(from: user)
                print("saved user to DB!")
            } catch {
                
                print("Error saving to DB")
            }
            userId = ref!.documentID
            print("UserID: \(userId)")
            
            let user3 = Users( name: userName, email: userEmail, userIDinFG: userId ,groupCode: groupCode, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if auth.currentUser != nil {
                if let user2 = auth.currentUser {
                    do {
                        _ = try db.collection("Users").document(user2.uid).collection("userinfo").addDocument(from: user3)
                        print("saved user3 to DB!")
                    } catch {
                        print("Error saving to usergropcodes!")
                    }
                    do {
                        db.collection("FamilyGroup")
                            .document(groupCode)
                            .collection("users").document(userId).updateData(["userIDinFG": userId]) { err in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    print("Succes! updated userId in user3!")
                                }
                            }
                    }
                }
            }
        }
        return userId
    }
        
        
        
        //func updateUserLocationInFirestore() {
        //    //guard let authUser = Auth.auth().currentUser else {return}
        //
        //    db.collection("FamilyGroup").document(familyGroupVM.groupCode).collection("users")
        //        .addSnapshotListener { [self] snapshot, err in
        //        guard let snapshot = snapshot else {return}
        //        if let err = err {
        //            print("error getting document \(err)")
        //        } else {
        //            userLocation.removeAll()
        //            for document in snapshot.documents {
        //                let result = Result {
        //                    try document.data(as: Users.self)
        //                }
        //                switch result {
        //                case.success(let user) :
        //                    userLocation.append(user)
        //
        //                case .failure(let error) :
        //                    print("Error decoding item: \(error)")
        //                }
        //            }
        //        }
        //    }
        //
        //
        //
        //}
        
        
        
        // db.collection("FamilyGroup").document(groupCode).collection("users").document(userId)
        //     .updateData(["longitude": userLongitude, "latitude": userLongitude]) { err in
        //     if let err = err {
        //         print("error updating document \(err)")
        //     } else {
        //         print("Succes!")
        //             }
        //         }
        //     }
        
    }

