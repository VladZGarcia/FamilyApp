//
//  LogInView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-12.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseAuth

struct LogInView: View {
    @EnvironmentObject private var viewModel : AppViewModel
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    
    @State private var email = ""
    @State private var password = ""
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
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.black)
                    
                    TextField("Email Address", text: $email)
                        .keyboardType(.emailAddress)
                        .submitLabel(.continue)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(viewModel.wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .keyboardType(.alphabet)
                        .submitLabel(.done)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(viewModel.wrongPassword))
                    
                    Button("Login") {
                        guard !email.isEmpty, !password.isEmpty else {
                            viewModel.wrongUsername = 2
                            viewModel.wrongPassword = 2
                            return
                        }
                        viewModel.logIn(email: email, password: password)
                        startApp = true
                        
                            
                        
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                    
                    NavigationLink("Create Account", destination: SignUpView())
                        .padding()
                        .foregroundColor(.blue)
                    
                    
                }
            }
        }
        .ignoresSafeArea()
        //.navigationBarHidden(true)
        .onAppear {
            //viewModel.signout()
            
        }
        
        NavigationLink("", destination: ContentView(), isActive: $viewModel.signedIn)
          
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
