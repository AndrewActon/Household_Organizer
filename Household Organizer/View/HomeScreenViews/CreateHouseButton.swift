//
//  CreateHouseButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct CreateHouseButton: View {

    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Binding var createNewHouseShowing: Bool
    
    var body: some View {
        Button {
            homeScreenViewModel.houseState = .create
            createNewHouseShowing = true
        } label: {
            Text("Create New Household")
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(myrtleGreen)
                .clipShape(Capsule())        }
    }
}


