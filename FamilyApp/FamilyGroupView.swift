//
//  FamilyGroupView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-10.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseAuth

struct FamilyGroupView: View {
    @StateObject var familyGroupVM = FamilyGroupViewModel()
    @State private var familyGroupCode = ""
    @State private var newGroupCode = ""
    @State private var userName = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        
        NavigationView {
            
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
                    Text("write a name")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $userName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    Text("Your FamilyGroup Code!")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text("\(familyGroupVM.RandomGroupCode())")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Button("Share") {
                        // Authenticate user
                        //authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in "), isActive: $showingLoginScreen)
                    {
                        EmptyView()
                    }
                    Button {
                        //anonymouslyLogin()
                    } label: {
                        Text("Share to your familymembers")
                            .bold()
                            .foregroundColor(.blue)
                    }
                    SecureField("FamilyGroupCode", text: $newGroupCode)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    Button("Connect") {
                        // Authenticate user
                        //authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in"), isActive: $showingLoginScreen)
                    {
                        EmptyView()
                    }
                    //Button {
                    //    //anonymouslyLogin()
                    //} label: {
                    //    Text("Connect to a FamilyGroup")
                    //        .bold()
                    //        .foregroundColor(.blue)
                    //}
                }
            }
            .navigationBarHidden(true)
        }
    }
    
}

struct FamilyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyGroupView()
    }
}
