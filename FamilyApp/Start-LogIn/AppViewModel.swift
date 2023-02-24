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
    
    @Published var haveUserData = false
    @Published var wrongUsername = 0
    @Published var wrongPassword = 0
    @Published var signedIn = false
    @Published var haveDataForDB = false
    @Published var groupCode = ""
    @Published var userName = ""
    @Published var userId = ""
    @Published var loggedIn = false
    @Published var haveGroupCode = false
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func logIn(email: String, password: String) {
        print("login -> Signedin: \(self.loggedIn)")
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
    
    func getUserdata() {
        print("getUserData -> Have userdata: \(self.haveUserData)")
        print("getUserData groupcode: \(groupCode)")
        if auth.currentUser != nil {
            if let user = auth.currentUser {
                print("auth currentuser: \(user.uid)")
                db.collection("Users").document(user.uid).collection("userinfo").addSnapshotListener { [self] (snapshot, error) in
                    guard let snapshot = snapshot else {return}
                    
                    if let err = error {
                        print("Error getting document \(err)")
                        
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
                                haveGroupCode = true
                                signedIn = true
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
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
  
    
}
