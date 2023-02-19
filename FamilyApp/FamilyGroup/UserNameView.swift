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
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var viewModel : AppViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    
    @State private var userName = ""
    @State private var nameInUse = 0
    //@State private var userGroupCode = ""
    @State private var startApp = false
    
    var body: some View {
        NavigationStack {
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
                        
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        
                        .cornerRadius(10)
                        .padding()
                    Button("Start") {
                        familyGroupVM.randomGroupCode()
                        viewModel.userName = userName
                        viewModel.haveUserData = true
                        viewModel.haveGroupCode = true
                        
                        print("user: \(viewModel.haveUserData) code: \(viewModel.haveGroupCode)")
                        mapViewModel.saveToFirestore(userGroupCode: viewModel.groupCode, userName: viewModel.userName)
                        
                            self.startApp = true
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Text("You are signed in")
                        .foregroundColor(.black)
                    Button(action: {
                        viewModel.signout()
                        
                            startApp = true
                        
                    }, label: {
                        Text("Sign Out")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    })
                }
            }
        }
        .navigationBarHidden(true)
        NavigationLink("", destination: ContentView(), isActive: $startApp)
       
    }
    
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
