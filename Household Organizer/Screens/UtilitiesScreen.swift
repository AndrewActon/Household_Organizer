//
//  UtilitiesScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/20/23.
//

import SwiftUI

struct UtilitiesScreen: View {
    // MARK: - Properties
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @StateObject var utilitiesScreenViewModel = UtilitiesScreenViewModel()
    @State var createNewUtilityShowing: Bool = false
    
    // MARK: - Body
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    
                    Text(loginScreenViewModel.selectedHousehold?.name ?? "No Households Found")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                .background(cambridgeGreen)
                
                HStack {
                    Spacer()
                    
                    CreateUtilityButton(createNewUtilityShowing: $createNewUtilityShowing)
                        .padding()
                    
                    Spacer()
                }
                
                if utilitiesScreenViewModel.utilities == nil || utilitiesScreenViewModel.utilities!.isEmpty {
                    Spacer()
                } else {
                    ForEach(utilitiesScreenViewModel.utilities!) { utility in
                        UtilitiesSummaryView(utilitiesSheetShowing: $createNewUtilityShowing, utility: utility)
                    }
                }
                
                
            }
            .background(backgroundGradient)
            .environmentObject(utilitiesScreenViewModel)
            .task {
                guard let house = loginScreenViewModel.selectedHousehold,
                      let utilityIDs = await utilitiesScreenViewModel.setupView(household: house)
                else { return }
                
                utilitiesScreenViewModel.utilities = await utilitiesScreenViewModel.findUtilties(id: utilityIDs)
            }
        
            .sheet(isPresented: $createNewUtilityShowing) {
                UtilityDetailsSheet(isShowing: $createNewUtilityShowing, utilityState: utilitiesScreenViewModel.utilityState)
            }
            .environmentObject(utilitiesScreenViewModel)

    }
}

