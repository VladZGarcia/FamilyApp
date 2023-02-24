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
    
    @EnvironmentObject var mapViewModel : MapContentViewModel
    @EnvironmentObject var viewModel : AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var drawingWidth = false
 
    var body: some View {
        VStack(alignment: .leading) {
            Text("Loading Data")
                .bold()
 
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(.systemGray6))
                RoundedRectangle(cornerRadius: 3)
                    .fill(.indigo.gradient)
                    .frame(width: drawingWidth ? 250 : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 10).repeatForever(autoreverses: false), value: drawingWidth)
            }
            .frame(width: 250, height: 12)
            .onAppear {
                drawingWidth.toggle()
                viewModel.getUserdata()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
