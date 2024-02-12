//
//  CreateNewHouseViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum HouseState {
    case create
    case edit
}

@MainActor class HouseDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var id: String = UUID().uuidString
    @Published var name: String = ""
    @Published var occupants: [UserModel] = []
    @Published var houseState: HouseState?
    
    // MARK: - Methods
    func setupView(house: Household) async {
        if houseState == .edit {
            name = house.name
            for occupant in house.occupants {
                guard let user = await UserManager.shared.findUserByID(userID: occupant) else { return }
                occupants.self.append(user)
            }
        }
    }
    
    func createNewHouse() -> Household {
        HouseholdManager.shared.createNewHouse(id: id.self, name: name.self, occupants: occupants.self, utilities: nil)
        
        let userIDs = occupants.map { $0.id }
        
        let house = Household(id: id, name: name, occupants: userIDs, utilities: nil)
        
       return house
    }
    
    func searchForUserByEmail(email: String) async -> UserModel? {
        return await UserManager.shared.findUserByEmail(email: email)
    }
    
    func removeUserFromHousehold(user: UserModel) {
        if let index = occupants.firstIndex(where: { $0.email == user.email }) {
            occupants.remove(at: index)
        }
    }
    
    func updateHousehold(household: Household?) -> Household? {
        guard let household = household else { return nil }
        
        let occupantIDs = occupants.map { $0.id }
        
        let updatedHousehold = Household(id: household.id, name: name, occupants: occupantIDs, utilities: household.utilities)
        
        HouseholdManager.shared.updateHousehold(household: updatedHousehold)
        
        return updatedHousehold
    }
    
    func deleteHousehold(household: Household?) {
        guard let household = household else { return }
        
        HouseholdManager.shared.deleteHousehold(household: household)
    }

}




