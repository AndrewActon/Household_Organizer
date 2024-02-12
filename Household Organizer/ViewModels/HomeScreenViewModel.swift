//
//  HomeScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/20/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

@MainActor class HomeScreenViewModel: ObservableObject {
    // MARK: - Properties
    @Published var households: [Household]?
    @Published var houseState: HouseState?
    
    // MARK: - Methods
    
    func setupView() async -> Household? {
        let user = UserManager.shared.user
        
        guard let houses = await findUserHouseholds(user: user) else { return nil }
        
        self.households = houses
        
        return houses[0]
    }
    
    func findUserHouseholds(user: UserModel) async -> [Household]? {
        let households = await HouseholdManager.shared.findHouseholdsWithUserID(userID: user.id)
        return households
    }
    
    func removeOccupantFromHousehold(userID: String, household: Household?) -> Household? {
        guard let household = household else { return nil }
        
        let occupants = household.occupants
        
        let newOccupants = occupants.filter { $0 != userID }
        
        let updatedHousehold = Household(id: household.id, name: household.name, occupants: newOccupants, utilities: household.utilities)
        
        HouseholdManager.shared.updateHousehold(household: updatedHousehold)
        
        return updatedHousehold
    }
    
    func findOccupants(occupantIDs: [String]) async -> [UserModel]? {
        var users: [UserModel] = []
        
        for occupantID in occupantIDs {
            guard let user = await UserManager.shared.findUserByID(userID: occupantID) else { return nil }
            
            users.append(user)
        }
        
        return users
    }
    
}
