//
//  GetdataView.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-17.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth


struct GetDataView: View {
    @EnvironmentObject private var viewModel : AppViewModel
    //@EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    @State private var startApp = false
    
    var body: some View {
        NavigationView {
            Text("Getting data")
        }
            .onAppear() {
                viewModel.getUserdata()
                if viewModel.haveUserData {
                    mapViewModel.userId = viewModel.userId
                    startApp = true
                }
            }
        NavigationLink("", destination: ContentView(), isActive: $startApp)
            .environmentObject(mapViewModel)
    }
}
