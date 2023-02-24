//
//  ShoppingListViewModel.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-18.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth



class ShoppingListViewModel: NSObject, ObservableObject {
    
    
    
    let db = Firestore.firestore()
    @State var newItem : String = ""
    @ObservedObject var storeItems = StoreItems()
    
    
    func move(from source : IndexSet, to destination : Int) {
        storeItems.items.move(fromOffsets: source, toOffset: destination)
    }
    
    func listenToFirestore(_ groupCode: String) {
        
        db.collection("FamilyGroup").document(groupCode).collection("items").addSnapshotListener {  snapshot, err in
            guard let snapshot = snapshot else {return}
            
            print("new items")
            if let err = err {
                print("Error getting document \(err)")
            } else {
                //self.storeItems.items.removeAll()
                for document in snapshot.documents {
                    let result = Result{
                        try document.data(as: ItemList.self)
                    }
                    switch result {
                    case .success(let item) :
                        self.storeItems.items.append(item)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
    
    func saveToFirestore(_ newItem: String, groupCode: String) {
        let item = ItemList(itemName: newItem)
        do {
            _ = try  db.collection("FamilyGroup").document(groupCode).collection("items").addDocument(from: item)
        } catch {
            print("Error savin to DB")
        }
    }
    
    func addNewItem(newItem: String, groupCode: String) {
        saveToFirestore(newItem, groupCode: groupCode)
        
    }
}
