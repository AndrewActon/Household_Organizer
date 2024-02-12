//
//  EditHouseholdButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/28/24.
//

import SwiftUI

struct EditHouseholdButton: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Binding var houseDetailsShowing: Bool
    
    var body: some View {
        Button {
            homeScreenViewModel.houseState = .edit
            houseDetailsShowing = true
        } label: {
            Text("Edit Household")
        }
        .font(.system(size: 12, weight: .bold))
        .padding()
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

