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
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    @EnvironmentObject private var viewModel : AppViewModel
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    //@Published var groupCode = ""
    //@Published var userName = ""
    
    func randomGroupCode() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        viewModel.groupCode = String((0..<6).map{ _ in letters.randomElement()! })
        print("start random groupCode: \(viewModel.groupCode)")
        while checkGroupCode(groupCode: viewModel.groupCode) {
            viewModel.groupCode = String((0..<6).map{ _ in letters.randomElement()! })
            
        }
        print("after check groupCode: \(viewModel.groupCode)")
        print("group code db logged in: \(auth.currentUser)")
        if auth.currentUser != nil {
            let dbGroupCode = FamilyGroupCode(groupCode: viewModel.groupCode)
            do {
                _ = try db.collection("GroupCodes").addDocument(from: dbGroupCode)
                
                print("after db groupCode: \(viewModel.groupCode)")
            } catch {
                print("Error saving to DB!")
                viewModel.haveGroupCode = false
                return
            }
            
        }
        
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
