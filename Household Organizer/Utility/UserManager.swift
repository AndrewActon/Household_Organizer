//
//  UserManager.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/4/24.
//

import Foundation
import FirebaseFirestoreSwift

class UserManager {
    
    static let shared = UserManager()
    private let usersCollectionString: String = "Users"
    
    //Production code
    var user: UserModel = UserModel(id: "", name: "", email: "")
    
    func findUserByEmail(email: String) async -> UserModel? {
        //Create reference
        let docRef = AppDelegate.db.collection(usersCollectionString).whereField("email", isEqualTo: email.lowercased())
        
        do {
            //Query firebase
            let query = try await docRef.getDocuments()
            
            for doc in query.documents {
                let user = try doc.data(as: UserModel.self)
                
                return user
            }
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return nil
        }
        
        return nil
    }
    
    func findUserByID(userID: String) async -> UserModel? {
        //Create Reference
        let docRef = AppDelegate.db.collection(usersCollectionString).document(userID)
        
        do {
            let user = try await docRef.getDocument(as: UserModel.self)
            return user
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return nil
        }
    }
    
    func deleteUser(userID: String) {
        let docRef = AppDelegate.db.collection(usersCollectionString).document(userID)
        
        docRef.delete()
    }
    
    
}
