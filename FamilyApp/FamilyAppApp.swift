//
//  FamilyAppApp.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI
import Firebase

@main
struct FamilyAppApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MapContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
