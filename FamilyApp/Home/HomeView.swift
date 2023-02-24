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
                            presentationMode.wrappedValue.dismiss()
                            viewModel.haveGroupCode = false
                            viewModel.haveUserData = false
                            mapViewModel.mapSignedIn = false
                            mapViewModel.startLocationUpdates()
                        }, label: {
                            Image(systemName: "line.horizontal.3.decrease")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.gray)
                                .padding(.all)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color(.black).opacity(0.3), radius: 8, x: 8, y: 8)
                            
                                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                            
                            
                        })
                        
                    }
                    .position(x: 345, y: 665)
                    //ZStack {
                    //     Image(systemName: "person.3.sequence.fill")
                    //         .foregroundColor(.blue)
                    //         .frame(width:50, height: 50)
                    //         .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    //         .cornerRadius(30)
                    //
                    //
                    // }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.background(.white)
                    //.edgesIgnoringSafeArea(.all)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            .ignoresSafeArea()
            //NavigationLink("", destination: ContentView() , isActive: $gotoView)
            //   .environmentObject(mapViewModel)
            //    .environmentObject(viewModel)
            
            }
        }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
