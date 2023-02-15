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
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    
    let db = Firestore.firestore()
    @Published var groupCode = ""
    @Published var userName = ""
    func randomGroupCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        groupCode = String((0..<6).map{ _ in letters.randomElement()! })
        db.collection("GroupCodes").document(groupCode)
        // while checkGroupCode(groupCode: groupCode) {
        //     groupCode = String((0..<6).map{ _ in letters.randomElement()! })
    //}
        //if !checkGroupCode(groupCode: groupCode) {
    //let dbGroupCode = FamilyGroupCode(groupCode: groupCode)
           // do {
           //     _ = try db.collection("GroupCodes").document(groupCode).collection(dbGroupCode).addDocument(from: dbGroupCode)
           // } catch {
           //     print("Error saving to DB")
           // }
        //}
            
            return groupCode
    }
    
    //func checkGroupCode(groupCode: String) -> Bool {
    //    var codeExist = false
    //    let dbcheck = db.collection("GroupCodes")
    //    dbcheck.whereField("groupCode", isEqualTo: groupCode).getDocuments() { query, err in
    //
    //        if let err = err {
    //            print("error getting document: \(err)")
    //        } else {
    //
    //            if let document = query?.documents {
    //                if document.exists() {
    //                    codeExist = true
    //                }
    //            }
    //        }
    //    }
    //    return codeExist
    //}
    
    
}
