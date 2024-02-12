//
//  UtilityManager.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/4/24.
//

import Foundation
import FirebaseFirestoreSwift

class UtilityManager {
    
    static let shared = UtilityManager()
    private let utilityCollectionString: String = "Utilities"
    private let payStatusSubCollectionString: String = "PayStatus"
    
    func createNewUtility(utility: Utility) {
        //1. - Utility collection
        var utilityCollection = utility
        utilityCollection.payStatus = nil
        
        let docRefUtility = AppDelegate.db.collection(utilityCollectionString).document(utility.id)
        
        do {
            try docRefUtility.setData(from: utilityCollection)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
        
        //2. - Paystatus subcollection
        guard let payStatus = utility.payStatus else { return }
        for status in payStatus {
            let docRefPayStatus = AppDelegate.db.collection(utilityCollectionString).document(utility.id).collection(payStatusSubCollectionString).document(status.id)
            
            do {
                try docRefPayStatus.setData(from: status)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
    }
    
    func findUtilityWithID(id: String) async -> Utility? {
        //Create Reference
        let docRef = AppDelegate.db.collection(utilityCollectionString).document(id)
        
        do {
            var utility = try await docRef.getDocument(as: Utility.self)
            
            let payStatus = await findPayStatusForUtility(utility: utility)
            
            utility.payStatus = payStatus
            
            return utility
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
        
        return nil
    }
    
    func findPayStatusForUtility(utility: Utility) async -> [PayStatus]? {
        var payStatus: [PayStatus] = []
        let documentID = utility.id
        let docRef = AppDelegate.db.collection(utilityCollectionString).document(documentID).collection(payStatusSubCollectionString)
        
        do {
            let querySnapshot = try await docRef.getDocuments()
            
            for document in querySnapshot.documents {
                let status = try document.data(as: PayStatus.self)
                payStatus.append(status)
            }
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
        
        return payStatus
    }
    
    func updateUtility(utility: Utility) {
        //Utility update
        let docRef = AppDelegate.db.collection(utilityCollectionString).document(utility.id)
        
        var utilityCollection = utility
        utilityCollection.payStatus = nil
        
        do {
            try docRef.setData(from: utilityCollection)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
        
        //PayStatus update
        guard let payStatus = utility.payStatus else { return }
        
        for status in payStatus {
            let payStatusDocRef = AppDelegate.db.collection(utilityCollectionString).document(utility.id).collection(payStatusSubCollectionString).document(status.id)
            
            do {
                try payStatusDocRef.setData(from: status)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
    }
    
    func deleteUtility(utility: Utility, household: Household) async -> Household? {
        //Delete payStatus subcollection
        guard let payStatus = utility.payStatus else { return nil }
        
        do {
            for payStatus in payStatus {
                let subCollectionDocRef = AppDelegate.db.collection(utilityCollectionString).document(utility.id).collection(payStatusSubCollectionString).document(payStatus.id)
                
                try await subCollectionDocRef.delete()
            }
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
        
        //Delete utilityDocument
        let docRef = AppDelegate.db.collection(utilityCollectionString).document(utility.id)
        
        do {
            try await docRef.delete()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
        
        //Remove utilityID from household
        let house = await HouseholdManager.shared.deleteUtility(household: household, utilityID: utility.id)
        
        return house
    }
    
}

