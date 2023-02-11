//
//  FamilyGroupViewModel.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-10.
//

import SwiftUI
import Firebase
import MapKit

class FamilyGroupViewModel: NSObject, ObservableObject {
    @StateObject private var viewModel = MapContentViewModel()
    let db = Firestore.firestore()
    @Published var groupCode = ""
    
    func RandomGroupCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
         groupCode = String((0..<6).map{ _ in letters.randomElement()! })
        return groupCode
        
        
    }
    
    func saveToFirestore(groupCode: String, userName: String) {
        let group = FamilyGroupCode(groupCode: groupCode)
        
        
        if let location = viewModel.manager.location{
            let user = Users(name: userName, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            guard let authUser = Auth.auth().currentUser else {return}
            do {
                _ = try db.collection("FamilyGroup")
                    .document(groupCode)
                    .collection("users")
                    .document(authUser.uid)
                    .collection("user").addDocument(from: user)
            } catch {
                print("Error saving to DB")
            }
        }
    }
}
