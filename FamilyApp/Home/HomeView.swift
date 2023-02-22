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
    
    //private let views: [any View] = [MapContentView(), ShoppingListView()]
        
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
                }
                .tabViewStyle(.automatic)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .cornerRadius(30)
                .padding(10)
                
                //Text("Try to swipe!")
                //    .italic()
                VStack {
                    
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        Text("Signout")
                            .foregroundColor(.white)
                            .frame(width: 100, height :40)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .background(Color.accentColor)
                        
                    }
                   ZStack {
                        Image(systemName: "person.3.sequence.fill")
                            .foregroundColor(.blue)
                            .frame(width:50, height: 50)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                            .cornerRadius(30)
                            
                        
                    }
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   //.background(.white)
                   //.edgesIgnoringSafeArea(.all)
                }.frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
