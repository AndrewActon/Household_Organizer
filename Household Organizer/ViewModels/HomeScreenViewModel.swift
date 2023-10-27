//
//  HomeScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/20/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor class HomeScreenViewModel: ObservableObject {
    // MARK: - Properties
    @Published var user: UserModel = UserModel(id: "", name: "", email: "")
    @Published var selectedHousehold: Household?
    @Published var households: [Household]?
    
    // MARK: - Methods
    func updateUserName(name: String) async -> Bool {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        do {
            //Update Authentication User
            try await changeRequest?.commitChanges()
            user.name = name
            
            //Update Firestore User
            try await AppDelegate.db.collection("Users").document(user.email).updateData(["name" : name])
            
            return true
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return false
        }
    }
    
    func findUserHouseholds(user: UserModel) async -> [Household]? {
        var households: [Household] = []
        let docRef = AppDelegate.db.collection("Households").whereField("occupants", arrayContains: user.email.lowercased())
        
        do {
            let querySnapshot = try await docRef.getDocuments()
            
            for document in querySnapshot.documents {
                let household = Household(
                    id: document["id"] as? String ?? "",
                    name: document["name"] as? String ?? "",
                    occupants: document["occupants"] as? [String] ?? [])
                
                households.append(household)
            }
            
            if households.isEmpty {
                return nil
            }
            
            selectedHousehold = households[0]
            
            return households
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return nil
        }
        
        
    }

}
