//
//  AppViewModel.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-12.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseAuth

class AppViewModel: NSObject, ObservableObject {
    
    //@EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
   //var mapViewModel : MapContentViewModel
    
    
    @Published var haveUserData = false
    @Published var wrongUsername = 0
    @Published var wrongPassword = 0
    @Published var signedIn = false
    @Published var haveGroupCode = false
    @Published var groupCode = ""
    @Published var userName = ""
    @Published var userId = ""
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
   // init(mapViewModel: MapContentViewModel) {
   //     self.mapViewModel = mapViewModel
   // }
    
    
   // func anonymouslyLogin() {
   //     auth.signInAnonymously() {[weak self] authResult, error in
   //         if let error = error {
   //             print("error signing in \(error)")
   //         } else {
   //                 self?.signedIn = true
   //         }
   //     }
   // }
    
    func logIn(email: String, password: String) {
        print("login -> Signedin: \(self.signedIn)")
        auth.signIn(withEmail: email, password: password) {[self]result, error in
            guard result != nil, error == nil else {
                self.wrongUsername = 2
                self.wrongPassword = 2
                return
            }
            
            self.signedIn = true
            
        print("login -> Signedin: \(self.signedIn)")
        }
    }
    
    func getFamilyGroup() {
        print("getFamilyGroup -> Have groupcode: \(haveGroupCode)")
        //var dbGroupCode = ""
        if auth.currentUser != nil {
            if let user = auth.currentUser {
                print("auth currentuser: \(user.uid)")

                db.collection("UserGroupCodes").document(user.uid).collection("groupcodes").addSnapshotListener { [self] (snapshot, error) in
                    guard let snapshot = snapshot else {return}
                    
                    if let err = error {
                        print("Error getting document \(err)")
                    } else {
                        
                        for document in snapshot.documents {
                            let result = Result{
                                try document.data(as: FamilyGroupCode.self)
                            }
                            switch result {
                            case .success(let gCode) :
                                groupCode = gCode.groupCode
                                print("groupcode: \(groupCode)")
                                
                                haveGroupCode = true
                                print("login -> Have groupcode: \(haveGroupCode)")
                            case .failure(let error) :
                                print("Error decoding item: \(error)")
                            }
                        }
                    }
                    
                }
    
            }
        }
        
    }
    
    func getUserdata() {
        print("getUserData -> Have userdata: \(self.haveUserData)")
        print("getUserData groupcode: \(groupCode)")
        if auth.currentUser != nil {
            if let user = auth.currentUser {
                print("auth currentuser: \(user.uid)")
                db.collection("Users").document(user.uid).collection("userinfo").addSnapshotListener { [self] (snapshot, error) in
                    guard let snapshot = snapshot else {return}
                    
                    if let err = error {
                        print("Error gtting document \(err)")
                        
                    } else {
                        for document in snapshot.documents {
                            
                            let result = Result{
                                try document.data(as: Users.self)
                            }
                            switch result {
                            case .success(let gUser) :
                                userName = gUser.name
                                groupCode = gUser.groupCode
                                userId = gUser.userIDinFG
                                haveUserData = true
                                print("username: \(userName) groupcode: \(groupCode)")
                                print("login -> Have userData: \(self.haveUserData)")
                            case .failure(let error) :
                                print("Error decoding item: \(error)")
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
        
    
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                
                return
            }
               
        }
    }
    
    func signout() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    func updateLocationInFirestore(userLatitude: Double, userLongitude: Double) {
        
        //guard let userEmail = auth.currentUser?.email else {return}
        // var refQuary: DocumentReference? = nil
        // do {
        //   refQuary = db.collection("FamilyGroup")
        //       .document(groupCode)
        //       .collection("users").whereField("email", isEqualTo: userEmail)
        // } catch {
        //     print("Error")
        // }
        // userId = refQuary!.documentID
        // print("UserID: \(userId)")
        //
        //let query = db.collection("FamilyGroup")
        //    .document(groupCode)
        //    .collection("users").whereField("email", isEqualTo: userEmail)
        db.collection("FamilyGroup")
            .document(groupCode)
            .collection("users").document(userId).updateData(["longitude": userLongitude, "latitude": userLongitude]) { err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    print("Succes!")
                    
                    
                }
            }
    }
    
}
