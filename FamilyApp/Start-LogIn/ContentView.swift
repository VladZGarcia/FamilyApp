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
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    
    
    var body: some View {
        
        NavigationStack {
            if viewModel.signedIn {
                GetDataView()
               
                if viewModel.haveUserData{
                    ShoppingListView()
                }
            } else  {
                LogInView()
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            print("haveUserData: \($viewModel.haveUserData) signedIn: \(viewModel.signedIn)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



