//
//  CreateNewUtilityViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import Foundation
import FirebaseFirestore

enum UtilityState {
    case create
    case edit
}

@MainActor class UtilityDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var uuid: String = UUID().uuidString
    @Published var name: String = ""
    @Published var totalCost: Double = 0.00
    @Published var instructions: String = ""
    @Published var dueDate: Date = .now
    @Published var payStatus: [PayStatus] = []
    @Published var utilityState: UtilityState?
    @Published var household: Household?
    @Published var alertIsShowing: Bool = false
    var editID: String?
    
    func setupView(household: Household) async {
        switch utilityState {
        case .create:
            //Create payStatus for each occupant
            for occupant in household.occupants {
                await createPayStatus(userID: occupant)
            }
            
        case .edit:
            guard let id = editID,
                  let utility = await UtilityManager.shared.findUtilityWithID(id: id)
            else { return }
            
            self.uuid = utility.id
            self.name = utility.name
            self.totalCost = utility.amount
            self.instructions = utility.instructions
            self.dueDate = utility.dueDate
            self.payStatus = utility.payStatus ?? []
            
        case nil:
            //Error handling
            utilityState = .create
        }
    }
    
    func createPayStatus(userID: String) async {
        //Find username
        guard let user = await UserManager.shared.findUserByID(userID: userID),
              let name = user.name
        else { return }
        
        let payStatus = PayStatus(id: userID, name: name, amount: 0.00, paid: false)
        self.payStatus.append(payStatus)
    }
    
    func findUser(userID: String) async -> UserModel? {
        guard let user = await UserManager.shared.findUserByID(userID: userID) else { return nil}
        return user
    }
    
    func getAmount(userID: String) -> Double {
        guard let index = payStatus.firstIndex(where: { $0.id == userID }) else { return 0.00 }
        
        let amount = payStatus[index].amount
        
        return amount
    }
    
    func setAmount(userID: String, amount: Double) {
        guard let index = payStatus.firstIndex(where: { $0.id == userID }) else { return }
        
        payStatus[index].amount = amount
    }
    
    func splitEvenly() {
        //Calculate Even Split
        let dividend = totalCost
        let divisor = Double(payStatus.count)
        let quotient = dividend / divisor
    
        //Add amount owed to each occupant
        for status in payStatus {
            guard let index = payStatus.firstIndex(where: { $0.id == status.id }) else { return }
            
            payStatus[index].amount = quotient
        }

    }
    
    func createNewUtility() -> Household? {
        let utility = Utility(id: uuid, name: name, amount: totalCost, instructions: instructions, dueDate: dueDate, payStatus: payStatus)
        
        UtilityManager.shared.createNewUtility(utility: utility)
        
        let household = updateHouseholdWithNewUtility()
        
        return household
    }
    
    
    func updateUtility() {
        let utility = Utility(id: uuid, name: name, amount: totalCost, instructions: instructions, dueDate: dueDate, payStatus: payStatus)
        
        UtilityManager.shared.updateUtility(utility: utility)
    }
    
    func deleteUtility() async -> Household? {
        let utility = Utility(id: uuid, name: name, amount: totalCost, instructions: instructions, dueDate: dueDate, payStatus: payStatus)
        guard let household = household else { return nil }
        
        let house = await UtilityManager.shared.deleteUtility(utility: utility, household: household)
        
        return house
    }
    
    func updateHouseholdWithNewUtility() -> Household? {
        guard var household = self.household else { return nil }
        
        if household.utilities != nil {
            household.utilities?.append(uuid)
        } else {
            household.utilities = [uuid]
        }

        HouseholdManager.shared.updateHousehold(household: household)
        
        return household
    }
    
}
