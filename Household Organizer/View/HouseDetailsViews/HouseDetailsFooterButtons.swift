//
//  HouseDetailsFooterButtons.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/27/24.
//

import SwiftUI

struct HouseDetailsFooterButtons: View {
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var houseDetailsViewModel: HouseDetailsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Binding var isShowing: Bool
    private var createButtonIsDisabled: Bool {
        houseDetailsViewModel.name.isEmpty || houseDetailsViewModel.occupants.isEmpty
    }
    
    var body: some View {
        if houseDetailsViewModel.houseState == .create {
            Button {
                //Update Firebase
                let house = houseDetailsViewModel.createNewHouse()
                //Update views
                loginScreenViewModel.selectedHousehold = house
                homeScreenViewModel.households?.append(house)
                //Dismiss sheet
                isShowing = false
            } label: {
                Text("Create")
            }
            .disabled(createButtonIsDisabled)
            .font(.system(size: 16, weight: .bold))
            .padding()
            .foregroundColor(.white)
            .background(createButtonIsDisabled ? .red : myrtleGreen)
            .clipShape(Capsule())
        } else if houseDetailsViewModel.houseState == .edit {
            HStack {
                Button {
                    //Update Firebase
                    guard let household = houseDetailsViewModel.updateHousehold(household: loginScreenViewModel.selectedHousehold) else {
                        isShowing = false
                        return
                    }
                    //Update homescreen
                    guard let households = homeScreenViewModel.households else {
                        isShowing = false
                        return
                    }
                    var updatedHouseholds = households.filter { $0.id != household.id }
                    updatedHouseholds.append(household)
                    homeScreenViewModel.households = updatedHouseholds
                    //Dismiss sheet
                    isShowing = false
                } label: {
                    Text("Save Changes")
                }
                .disabled(createButtonIsDisabled)
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.white)
                .background(createButtonIsDisabled ? .red : myrtleGreen)
                .clipShape(Capsule())
                
                Button {
                    //Update Firebase
                    houseDetailsViewModel.deleteHousehold(household: loginScreenViewModel.selectedHousehold)
                    //Update Views
                    guard let oldHouse = loginScreenViewModel.selectedHousehold,
                          let households = homeScreenViewModel.households
                    else {
                        isShowing = false
                        return
                    }
                    
                    let updatedHouseholds = households.filter { $0.id != oldHouse.id }
                    homeScreenViewModel.households = updatedHouseholds
                    //Dismiss Sheet
                    isShowing = false
                } label: {
                    Text("Delete Household")
                }
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.white)
                .background(.red)
                .clipShape(Capsule())
            }
            
        }
        
    }
}

