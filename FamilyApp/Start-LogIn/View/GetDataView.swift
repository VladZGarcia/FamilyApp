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
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel : AppViewModel
    @EnvironmentObject var mapViewModel : MapContentViewModel
    @State private var startApp = false
    
    var body: some View {
        Color.blue
        Text("Getting data")
            .onAppear() {
                viewModel.getUserdata()
                presentationMode.wrappedValue.dismiss()
            }
    }
}
