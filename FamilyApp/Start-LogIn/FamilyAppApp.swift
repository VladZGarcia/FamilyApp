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
  
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var viewModel = AppViewModel()
    @StateObject var familyGroupVM = FamilyGroupViewModel()
    @StateObject var mapViewModel = MapContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(familyGroupVM)
                .environmentObject(mapViewModel)
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
