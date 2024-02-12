//
//  CreateNewHouseView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/25/23.
//

import SwiftUI

struct HouseDetailsSheet: View {
    // MARK: - Properties
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @StateObject var houseDetailsViewModel = HouseDetailsViewModel()
    @Binding var isShowing: Bool
    let houseState: HouseState
    private var createButtonIsDisabled: Bool {
        houseDetailsViewModel.name.isEmpty || houseDetailsViewModel.occupants.isEmpty
    }
    
    init(isShowing: Binding<Bool>, houseState: HouseState) {
        self._isShowing = isShowing
        self.houseState = houseState
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            HeaderView()
            
            HouseDetailsView()
            
            OccupantGridView()
            
            SearchForUserView()
            
            Spacer()
            
            HouseDetailsFooterButtons(isShowing: $isShowing)
            
        }
        .padding()
        .background(backgroundGradient)
        .environmentObject(houseDetailsViewModel)
        
        .onAppear {
            //Set house state for view model
            houseDetailsViewModel.houseState = houseState
            //Unwrap selected household
            guard let house = loginScreenViewModel.selectedHousehold else { return }
            //Call view setup
            Task {
                await houseDetailsViewModel.setupView(house: house)                
            }
        }
        
        
    }
    
}


