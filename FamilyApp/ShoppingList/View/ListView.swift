//
//  ListView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct ListView: View {
    
    @EnvironmentObject var viewModel : AppViewModel
    @EnvironmentObject var mapViewModel : MapContentViewModel
    @StateObject var shoppingListViewModel = ShoppingListViewModel()
    
    let db = Firestore.firestore()
    @State var newItem : String = ""
    
    var searchBar : some View {
        HStack {
            TextField("Enter in new item", text: self.$newItem)
            Button(action: {
                shoppingListViewModel.addNewItem(dbNewItem: newItem,groupCode: mapViewModel.mapGroupCode)}, label: {
                    Text("Add New")
                })
            
        }
    }
    
    var body: some View {
        VStack {
            searchBar.padding()
            List{
                ForEach(shoppingListViewModel.storeItems.items) {
                    item in
                    ItemRowView(item: item)
                }.onMove(perform: shoppingListViewModel.move)
                    .onDelete() { indexSet in
                        for index in indexSet {
                            let item = shoppingListViewModel.storeItems.items[index]
                            if let id = item.id
                                
                            {
                                db.collection("FamilyGroup").document(mapViewModel.mapGroupCode).collection("items").document(id).delete()
                            }
                        }
                    }
            }.onAppear() {
                if viewModel.haveUserData {
                    print("ShoppingList----> HaveuserData pre listenToFirestore")
                    shoppingListViewModel.listenToFirestore(mapViewModel.mapGroupCode)
                }
            }
            .navigationBarTitle("ShoppingList")
            .navigationBarItems(trailing: EditButton())
        }
        .padding()
    }
}
