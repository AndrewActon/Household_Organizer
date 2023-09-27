//
//  Household_OrganizerApp.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    
    static let db = Firestore.firestore()
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099)
        
        // MARK: - Firestore Emulator
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080";
        settings.isPersistenceEnabled = false;
        settings.isSSLEnabled = false;
        Firestore.firestore().settings = settings
        
        return true
    }
}

@main
struct Household_OrganizerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
