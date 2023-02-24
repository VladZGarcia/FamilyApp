//
//  Shoppinglist.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-15.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct ShoppingListView: View {
    
    @EnvironmentObject var mapViewModel : MapContentViewModel
    @StateObject var shoppingListViewModel = ShoppingListViewModel()
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        NavigationView {
            ListView()
        }
    }
}

