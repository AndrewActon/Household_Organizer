//
//  HouseholdManager.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/4/24.
//

import Foundation
import FirebaseFirestoreSwift

class HouseholdManager {
    
    static let shared = HouseholdManager()
    private let householdsCollectionString: String = "Households"
//    var selectedHousehold: Household? = nil
    
    func findHouseholdsWithUserID(userID: String) async -> [Household]? {
        var households: [Household] = []
        let docRef = AppDelegate.db.collection(householdsCollectionString).whereField("occupants", arrayContains: userID)
        
        do {
            let snapshot = try await docRef.getDocuments()
            
            for document in snapshot.documents {
                let house = try document.data(as: Household.self)
                households.append(house)
            }
            
            return households.isEmpty ? nil : households
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return nil
        }
    }
    
    func createNewHouse(id: String, name: String, occupants: [UserModel], utilities: [Utility]?) {
        //Extract IDs from occupants and utilities
        var userIDs: [String] = []
        var utilityIDs: [String] = []
        
        for occupant in occupants {
            let id = occupant.id
            userIDs.append(id)
        }
        
        if utilities != nil {
            for utility in utilities! {
                let id = utility.id
                utilityIDs.append(id)
            }
        }
        //Create Household Object
        let house = Household(id: id, name: name, occupants: userIDs, utilities: utilityIDs)
        //Create Reference
        let docRef = AppDelegate.db.collection(householdsCollectionString).document(id)
        //Set Document
        do {
            try docRef.setData(from: house)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
    }
    
    func updateHousehold(household: Household) {
        //Create Reference
        let docRef = AppDelegate.db.collection(householdsCollectionString).document(household.id)
        //Set document
        do {
            try docRef.setData(from: household)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
    }
    
    func deleteUtility(household: Household, utilityID: String) async -> Household? {
        var updatedHousehold = household
        let utilities = updatedHousehold.utilities
        
        let newUtilities = utilities?.filter { $0 != utilityID }
        
        updatedHousehold.utilities = newUtilities
        
        updateHousehold(household: updatedHousehold)
        
        return updatedHousehold
    }
    
    func deleteHousehold(household: Household) {
        let docRef = AppDelegate.db.collection(householdsCollectionString).document(household.id)
        
        docRef.delete()
    }
    
}
