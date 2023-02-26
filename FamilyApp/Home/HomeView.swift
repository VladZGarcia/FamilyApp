//
//  HomeView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel : AppViewModel
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State private var gotoContentView = false
    @State private var gotoView = false
    
    var body: some View {
        
        ZStack {
            TabView {
                MapContentView()
                    .tabItem {
                        Label("map", systemImage:"map")
                    }
                ShoppingListView()
                    .tabItem {
                        Label("list", systemImage:"list.bullet.circle.fill")
                    }
                FamilyGroupView()
                    .tabItem {
                        Label("group", systemImage:"person.3.sequence.fill")
                    }
                    //.toolbarBackground(Color.white, for: .tabBar)
            }
            .edgesIgnoringSafeArea(.vertical)
            .tint(.pink)
            .tabViewStyle(.automatic)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .cornerRadius(30)
            .padding(10)
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

