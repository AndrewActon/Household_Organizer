//
//  UtilitiesScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import Foundation

@MainActor class UtilitiesScreenViewModel: ObservableObject {
    // MARK: - Properties
    @Published var utilities: [Utility]?
    @Published var utilityState: UtilityState?
    @Published var editID: String?
    
    // MARK: - Methods
    func setupView(household: Household) async -> [String]? {
        guard let utilityIDs = household.utilities else { return nil }
        
        return utilityIDs
    }
    
    func findUtilties(id: [String]) async -> [Utility] {
        var utilities: [Utility] = []
        
        for id in id {
            guard let utility = await UtilityManager.shared.findUtilityWithID(id: id) else { return utilities }
            utilities.append(utility)
        }
        
        return utilities
    }
    
    func markAsPaid(utility: Utility) async -> Utility {
        //Match user
        guard let index = utility.payStatus?.firstIndex(where: { $0.id == UserManager.shared.user.id }),
              var payStatus = utility.payStatus
        else { return  utility }
        //Change paid
        payStatus[index].paid = true
        //Create updated utility
        var updatedUtility = utility
        updatedUtility.payStatus = payStatus
        //Update firebase via manager
        UtilityManager.shared.updateUtility(utility: updatedUtility)
        
        return updatedUtility
    }
    
    func findUserWithPayStatus(status: PayStatus) async -> UserModel? {
        let userId = status.id
        
        let user = await UserManager.shared.findUserByID(userID: userId)
        
        return user
    }
}
