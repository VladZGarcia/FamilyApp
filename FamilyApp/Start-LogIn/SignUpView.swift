//
//  SignUpView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-11.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject private var viewModel : AppViewModel
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var startApp = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.indigo
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack {
                    Text("SignUp")
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
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .keyboardType(.alphabet)
                        .submitLabel(.done)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                   
                    
                    Button("Create Account") {
                        guard !email.isEmpty, !password.isEmpty else {
                            viewModel.wrongUsername = 2
                            viewModel.wrongPassword = 2
                            return
                        }
                        //familyGroupVM.randomGroupCode()
                        viewModel.signUp(email: email, password: password)
                        startApp = true
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                }
                
            }
            .ignoresSafeArea()
            //.navigationBarHidden(true)
            NavigationLink("", destination: UserNameView(), isActive: $startApp)
            
        } 
    }
}

struct SignUpView_Previews: PreviewProvider {
static var previews: some View {
    ContentView()
}
}
