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
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var familyGroupCode = ""
    @State private var newGroupCode = ""
    @State private var userName = ""
    @State private var wrongGroupCode = 0
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
                
                Text("FamilyGroup Code!")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                
                
                Text("\(mapViewModel.mapGroupCode)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)
                //.padding()
                
                Button("Share") {
                    share()
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("Share to your familymembers")
                        .bold()
                        .foregroundColor(.blue)
                        .padding()
                }
                TextField("FamilyGroupCode", text: $newGroupCode)
                    .preferredColorScheme(.light)
                    .foregroundColor(.black)
                    .background(Color.black.opacity(0.05))
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongGroupCode))
                Button("Connect") {
                    mapViewModel.mapGroupCode = newGroupCode
                    viewModel.groupCode = newGroupCode
                    startApp = true
                    viewModel.haveGroupCode = true
                    viewModel.haveUserData = true
                    if let id = mapViewModel.updateDataInFirestore(userGroupCode: newGroupCode, userName: viewModel.userName) {
                        viewModel.userId = id
                        mapViewModel.mapUserId = id
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                Button {
                    viewModel.signOut()
                    startApp = true
                    viewModel.haveGroupCode = false
                    viewModel.haveUserData = false
                    
                    mapViewModel.mapSignedIn = false
                    mapViewModel.startLocationUpdates()
                    
                } label: {
                    Text("SignOut")
                        .bold()
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
            .navigationBarHidden(true)
        }
    }
    
    func share() {
        //guard let shareGroupCode = "\(mapViewModel.mapGroupCode)" else {return}
        let activityVC = UIActivityViewController(activityItems: [mapViewModel.mapGroupCode], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC,animated: true, completion: nil)
    }
}

struct FamilyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyGroupView()
    }
}
