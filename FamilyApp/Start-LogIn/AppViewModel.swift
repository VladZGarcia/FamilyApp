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
    @Published var wrongUsername = 0
    @Published var wrongPassword = 0
    @Published var signedIn = false
    @Published var haveUserName = false
    
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
   // func anonymouslyLogin() {
   //     auth.signInAnonymously() {[weak self] authResult, error in
   //         if let error = error {
   //             print("error signing in \(error)")
   //         } else {
   //
   //                 self?.signedIn = true
   //
   //
   //
   //         }
   //     }
   //
   // }
    
    func logIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {[weak self]result, error in
            guard result != nil, error == nil else {
                self?.wrongUsername = 2
                self?.wrongPassword = 2
                return
            }
                self?.signedIn = true
            print("login -> Signedin: \(self?.signedIn)")
        }
    }
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
                self?.signedIn = true
            
        }
        
    }
    
    func signout() {
        try? auth.signOut()
        
        self.signedIn = false
        
    }
    
    
}
