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
        
        NavigationView {
            if viewModel.signedIn {
                if viewModel.haveUserData{
                    
                    MapContentView()
                } else {
                    GetDataView()
                }
            } else  {
                LogInView()
            }
        }
        //.environmentObject(viewModel)
        .environmentObject(mapViewModel)
        //.environmentObject(familyGroupVM)
        //.ignoresSafeArea()
        .navigationBarHidden(true)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           // .environmentObject(AppViewModel())
           // .environmentObject(MapContentViewModel())
           // .environmentObject(FamilyGroupViewModel())
        
    }
}



