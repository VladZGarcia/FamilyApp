//
//  FamilyGroupViewModel.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-10.
//

import SwiftUI
import Firebase
import MapKit
import FirebaseAuth

class FamilyGroupViewModel: NSObject, ObservableObject {
    
    //@EnvironmentObject var viewModel : AppViewModel
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    //@Published var groupCode = ""
    //@Published var userName = ""
    
    func randomGroupCode() -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var groupCode = String((0..<6).map{ _ in letters.randomElement()! })
        print("start random groupCode: \(groupCode)")
        while checkGroupCode(groupCode: groupCode) {
            groupCode = String((0..<6).map{ _ in letters.randomElement()! })
            
        }
        print("after check groupCode: \(groupCode)")
        print("Random groupcode db logged in: \(auth.currentUser)")
        if auth.currentUser != nil {
            let dbGroupCode = FamilyGroupCode(groupCode: groupCode)
            do {
                _ = try db.collection("GroupCodes").addDocument(from: dbGroupCode)
                
                
                print("after db groupCode: \(groupCode)")
            } catch {
                print("Error saving to DB!")
               
                
            }
            
        }
        return groupCode
    }
        
        
        func checkGroupCode(groupCode: String) -> Bool {
            var codeExist = false
            let dbcheck = db.collection("GroupCodes")
            dbcheck.addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                if let err = err {
                    print("error getting document: \(err)")
                } else {
                    for document in snapshot.documents {
                        let result = Result{
                            try document.data(as: FamilyGroupCode.self)
                        }
                        switch result {
                        case .success(let gCode) :
                            if groupCode == gCode.groupCode {
                                print("Codeexist groupCode: \(groupCode) gCode: \(gCode.groupCode)")
                                codeExist = true
                            } else {
                                
                            }
                        case .failure(let error) :
                            print("Error decoding item: \(error)")
                        }
                    }
                }
            }
            return codeExist
        }
    
}
