//
//  UserNameView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-12.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseAuth

struct UserNameView: View {
    
    @EnvironmentObject var viewModel : AppViewModel
    @EnvironmentObject var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject var mapViewModel : MapContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var userName = ""
    @State private var nameInUse = 0
    @State private var startApp = false
    
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                Text("Username")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                //.padding()
                
                TextField("Username", text: $userName)
                    .preferredColorScheme(.light)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                
                    .cornerRadius(10)
                    .padding()
                Button("Start") {
                    viewModel.groupCode = familyGroupVM.randomGroupCode()
                    mapViewModel.mapGroupCode = viewModel.groupCode
                    viewModel.userName = userName
                    viewModel.haveUserData = true
                    if let id = mapViewModel.saveToFirestore(userGroupCode: viewModel.groupCode, userName: viewModel.userName) {
                        viewModel.userId = id
                        mapViewModel.mapUserId = id
                        viewModel.signedIn = true
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                Text("You are signed in")
                    .foregroundColor(.black)
                Button(action: {
                    viewModel.signOut()
                    
                    startApp = true
                    
                }, label: {
                    Text("Sign Out")
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    //.padding()
                })
            }
            
        }
        .environmentObject(viewModel)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
        
    }
    
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
