//
//  HomeScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import SwiftUI

struct HomeScreen: View {
    // MARK: - Properties
    @EnvironmentObject var loginViewModel: LoginScreenViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State private var houseDetailsShowing: Bool = false
    
    // MARK: - Body
    var body: some View {
            VStack {
                //Header
                HouseholdMenu()
                    .background(cambridgeGreen)
                
                //Button
                CreateHouseButton(createNewHouseShowing: $houseDetailsShowing)
                    .padding()
                
                //Summary
                HouseholdSummaryView(houseDetailsShowing: $houseDetailsShowing)
                
//                //Occupant List
//                if loginViewModel.selectedHousehold != nil {
//                    OccupantListView(occupantIDs: loginViewModel.selectedHousehold!.occupants)
//                }
                
                Spacer()
                
                EditHouseholdButton(houseDetailsShowing: $houseDetailsShowing)
                    .padding()
            }
            .environmentObject(homeScreenViewModel)
            .background(backgroundGradient)
            
            .sheet(isPresented: $houseDetailsShowing) {
                HouseDetailsSheet(isShowing: $houseDetailsShowing, houseState: homeScreenViewModel.houseState!)
                    .onDisappear {
                        Task {
                            let user = UserManager.shared.user
                            
                            guard let households = await homeScreenViewModel.findUserHouseholds(user: user) else { return }
                            
                            homeScreenViewModel.households = households
                            
                            loginViewModel.selectedHousehold = households[0]
                        }
                        houseDetailsShowing = false
                    }
                    .environmentObject(homeScreenViewModel)
            }

    }
}
