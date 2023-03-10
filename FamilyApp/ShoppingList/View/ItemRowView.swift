//
//  ItemRowView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-15.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct ItemRowView: View {
    
    @EnvironmentObject var mapViewModel : MapContentViewModel
    
    let db = Firestore.firestore()
    let item : ItemList
    
    var body: some View {
        HStack {
            Text(item.itemName)
            Spacer()
            Button(action: {
                if let id = item.id
                    
                {
                    db.collection("FamilyGroup").document(mapViewModel.mapGroupCode)
                        .collection("items").document(id).updateData(["isChecked": !item.isChecked])
                }
            }) {
                Image(systemName: item.isChecked ? "checkmark.square" : "square")
            }
        }
    }
}


