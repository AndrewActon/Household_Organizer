//
//  CreateNewHouseViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import Foundation
import FirebaseFirestore

@MainActor class HouseDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var household: Household?
    @Published var name: String = ""
    @Published var occupants: [UserModel] = []
    
    // MARK: - Methods
    func createNewHouse(name: String, occupants: [UserModel]) {
        var userEmails: [String] = []
        for occupant in occupants {
            userEmails.append(occupant.email)
        }

        var ref: DocumentReference? = nil
        ref = AppDelegate.db.collection("Households").addDocument(data: [
            "id" : UUID().uuidString,
            "name" : name,
            "occupants" : userEmails
        ]) { error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func searchForUserByEmail(email: String) async -> UserModel? {
        let docRef = AppDelegate.db.collection("Users").document(email.lowercased())
        var user: UserModel?
        
        do {
            let document = try await docRef.getDocument()
            
            user = UserModel(
                id: document["id"] as? String ?? "",
                name: document["name"] as? String ?? "",
                email: document["email"] as? String ?? "")
            
            return user
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return user
        }
    }
    
    func removeUserFromHousehold(user: UserModel) {
        if let index = occupants.firstIndex(where: { $0.email == user.email }) {
            occupants.remove(at: index)
        }
    }
    
}
