//
//  MainView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
//    // MARK: - Fetching Data
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    // MARK: - Properties
    @StateObject var auth = AuthenticationModel()
    let handle = Auth.auth().addStateDidChangeListener { auth, user in
        //
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            if auth.authenticationState == .authenticated {
                ContentView()
            } else {
                LoginView()
            }
        }
        .environmentObject(auth)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
