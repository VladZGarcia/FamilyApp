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
    @State private var login = false
    
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
        .environmentObject(mapViewModel)
        //.ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
      
           //print("in ContentView mapGroupCode: \(mapViewModel.mapGroupCode)")
            viewModel.signedIn = viewModel.isSignedIn
       }
         
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
            .environmentObject(MapContentViewModel())
            .environmentObject(FamilyGroupViewModel())
        
    }
}*/



