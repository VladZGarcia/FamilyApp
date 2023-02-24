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
    
    @Published var region = MKCoordinateRegion(center:MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan )
    @Published var userLocation = [Users(latitude: 37.3323341, longitude: -122.029)]
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    var manager = CLLocationManager()
    var location : CLLocationCoordinate2D?
    @Published var mapSignedIn = false
    @Published var mapUserId = ""
    @Published var mapGroupCode = ""
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    func startLocationUpdates() {
        manager.requestAlwaysAuthorization()
        
        if mapSignedIn {
            manager.startUpdatingLocation()
            manager.allowsBackgroundLocationUpdates = true
            manager.showsBackgroundLocationIndicator = true
        } else {
            manager.stopUpdatingLocation()
            manager.allowsBackgroundLocationUpdates = false
            manager.showsBackgroundLocationIndicator = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        
        if let location = location  {
            print("Plats uppdaterad \(location)")
            print("in mapContentView mapGroupCode: \(mapGroupCode)")
            
            updateLocationInFirestore(userLatitude: location.latitude, userLongitude: location.longitude)
            
            
        }
        
        
        
    }
    
    func updateLocationInFirestore(userLatitude: Double, userLongitude: Double) {
        db.collection("FamilyGroup")
            .document(mapGroupCode)
            .collection("users").document(mapUserId).updateData(["latitude": userLatitude, "longitude": userLongitude]) { err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.listenToFirestore()
                    print("Succes!")
                }
            }
    }
    
    func listenToFirestore() {
        print("in listenToFirestore mapGroupCode: \(mapGroupCode)")
        if mapGroupCode == ""
        {return}
        
        db.collection("FamilyGroup")
            .document(mapGroupCode)
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
    
    func saveToFirestore(userGroupCode: String, userName: String) -> String? {
        
        guard let userEmail = auth.currentUser?.email else {return nil}
        var ref: DocumentReference? = nil
        
        if let location = manager.location{
            let user = Users( name: userName, email: userEmail ,groupCode: userGroupCode, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            guard auth.currentUser != nil else {return nil}
            do {
                ref = try db.collection("FamilyGroup")
                    .document(userGroupCode)
                    .collection("users").addDocument(from: user)
                print("saved user to DB!")
            } catch {
                
                print("Error saving to DB")
            }
            mapUserId = ref!.documentID
            print("UserID: \(mapUserId)")
            
            let user3 = Users( name: userName, email: userEmail, userIDinFG: mapUserId ,groupCode: userGroupCode, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if auth.currentUser != nil {
                if let user2 = auth.currentUser {
                    
                    do {
                        _ = try db.collection("Users").document(user2.uid).collection("userinfo").addDocument(from: user3)
                        print("saved user3 to DB!")
                    } catch {
                        print("Error saving to userInfo!")
                    }
                    do {
                        db.collection("FamilyGroup")
                            .document(userGroupCode)
                            .collection("users").document(mapUserId).updateData(["userIDinFG": mapUserId]) { err in
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
        return mapUserId
    }
    
    func updateDataInFirestore(userGroupCode: String, userName: String) -> String? {
        
        guard let userEmail = auth.currentUser?.email else {return nil}
        var ref: DocumentReference? = nil
        
        if let location = manager.location{
            let user = Users( name: userName, email: userEmail ,groupCode: userGroupCode, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            guard auth.currentUser != nil else {return nil}
            do {
                ref = try db.collection("FamilyGroup")
                    .document(userGroupCode)
                    .collection("users").addDocument(from: user)
                print("saved user to DB!")
            } catch {
                
                print("Error saving to DB")
            }
            mapUserId = ref!.documentID
            print("UserID: \(mapUserId)")
            
            //let user3 = Users( name: userName, email: userEmail, userIDinFG: mapUserId ,groupCode: userGroupCode, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if auth.currentUser != nil {
                if let user2 = auth.currentUser {
                    let updateRef = db.collection("Users").document(user2.uid).collection("userinfo")
                    updateRef.addSnapshotListener { snapshot, err in
                        guard let snapshot = snapshot  else{
                            print("Data was empty.  \(err)")
                            return
                        }
                        if let err = err {
                            print("error getting document \(err)")
                        } else {
                            for document in snapshot.documents {
                                let result = Result{
                                    try document.data(as: Users.self)
                                }
                                switch result {
                                case .success(let user) :
                                    guard let id = user.id else {return}
                                        updateRef.document(id).updateData(["groupCode": userGroupCode,
                                                                           "userIDinFG": self.mapUserId])
                                    
                                case .failure(let error) :
                                    print("Error decoding item: \(error)")
                                    
                                }
                                
                            }
                        }
                        do {
                            self.db.collection("FamilyGroup")
                                .document(userGroupCode)
                                .collection("users").document(self.mapUserId).updateData(["userIDinFG": self.mapUserId]) { err in
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
           
        }
        return mapUserId
    }
}
