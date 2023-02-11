//
//  FamilyAppApp.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct FamilyAppApp: App {
    

    init() {
        FirebaseApp.configure()
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
