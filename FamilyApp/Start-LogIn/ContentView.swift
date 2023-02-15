//
//  ContentView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseAuth


struct ContentView: View {
    @EnvironmentObject private var viewModel : AppViewModel
    
    
    var body: some View {
        
        NavigationStack {
            if viewModel.signedIn {
                if !viewModel.haveUserName {
                    UserNameView()
                } else {
                    ShoppingListView()
                }
            } else {
                LogInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
            print("haveUserName: \(viewModel.haveUserName) signedIn: \(viewModel.signedIn)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



