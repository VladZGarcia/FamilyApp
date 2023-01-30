//
//  FamilyAppApp.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import SwiftUI

@main
struct FamilyAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MapContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
