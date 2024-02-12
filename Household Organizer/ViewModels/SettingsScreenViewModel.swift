//
//  SettingsScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/25/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

@MainActor class SettingsScreenViewModel: ObservableObject {
    
    //Methods
    func deleteAccount(userID: String) {
        UserManager.shared.deleteUser(userID: userID)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
    }
    
}

