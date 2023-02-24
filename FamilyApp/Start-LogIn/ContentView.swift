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
    
    @EnvironmentObject var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject var mapViewModel : MapContentViewModel
    @EnvironmentObject var viewModel : AppViewModel
    
    
    var body: some View {
        
        NavigationView {
            if viewModel.signedIn {
                    if viewModel.haveUserData{
                        HomeView()
                    } else {
                        GetDataView()
                    }
                
            } else {
                LogInView()
            }
        }
        
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
           
            viewModel.signedIn = viewModel.isSignedIn
       }
         
    }
}




