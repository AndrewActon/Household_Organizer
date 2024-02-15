//
//  CreateNewUtilitySheet.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct UtilityDetailsSheet: View {
    // MARK: - Properties
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var utilitiesScreenViewModel: UtilitiesScreenViewModel
    @StateObject var utilityDetailsViewModel = UtilityDetailsViewModel()
    @State var isRotated: Bool = false
    @Binding var isShowing: Bool
    let utilityState: UtilityState?
    
    var body: some View {
            ScrollView {
                UtilityHeaderView()
                
                UtilityInfoView()
                
                UtilityDatePickerView()
                
                SplitEvenlyButton()

                ForEach($utilityDetailsViewModel.payStatus, id: \.id) { $status in
                    OccupantsList(payStatus: status)
                }
           
                UtilityInstructionsField()
                
                CreateNewUtilityButton(isShowing: $isShowing)
                
                Spacer()
            }
            .background(backgroundGradient)
            .environmentObject(utilityDetailsViewModel)
            .onAppear {
                //Set utility state
                utilityDetailsViewModel.utilityState = utilityState
                //Set editID
                utilityDetailsViewModel.editID = utilitiesScreenViewModel.editID
                //Unwrap household
                guard let household = loginScreenViewModel.selectedHousehold else { return }
                //Setup view
                Task {
                    await utilityDetailsViewModel.setupView(household: household)
                }
                //Set copy of household for manipulation
                utilityDetailsViewModel.household = household
            }
    }
    
}

