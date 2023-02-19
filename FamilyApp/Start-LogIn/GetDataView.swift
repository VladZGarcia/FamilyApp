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
    @EnvironmentObject private var familyGroupVM : FamilyGroupViewModel
    @EnvironmentObject private var mapViewModel : MapContentViewModel
    
    var body: some View {
        NavigationStack {
            Text("Getting data")
        }
            .onAppear() {
                viewModel.getUserdata()
            }
        NavigationLink("", destination: ContentView(), isActive: $viewModel.haveUserData)
    }
}
