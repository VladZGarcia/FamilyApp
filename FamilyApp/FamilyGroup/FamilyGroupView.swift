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
    @EnvironmentObject private var viewModel : AppViewModel
    //@EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    
    @State private var familyGroupCode = ""
    @State private var newGroupCode = ""
    @State private var userName = ""
    @State private var wrongGroupCode = 0
    
    
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
                    
                    Text("FamilyGroup Code!")
                        //.padding()
                        .font(.largeTitle)
                        .bold()
                        
                    
                    Text("\(familyGroupCode)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                        //.padding()
                    
                    Button("Share") {
                        // Authenticate user
                        //authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Button {
                        //share sheet
                    } label: {
                        Text("Share to your familymembers")
                            .bold()
                            .foregroundColor(.blue)
                            .padding()
                    }
                    SecureField("FamilyGroupCode", text: $newGroupCode)
                        //.padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongGroupCode))
                    Button("Connect") {
                        if let id = mapViewModel.saveToFirestore(userGroupCode: newGroupCode, userName: viewModel.userName) {
                            viewModel.userId = id
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
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
