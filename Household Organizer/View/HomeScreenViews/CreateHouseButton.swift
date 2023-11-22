//
//  CreateHouseButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct CreateHouseButton: View {

    @EnvironmentObject var summaryScreenViewModel: SummaryScreenViewModel
    @Binding var createNewHouseShowing: Bool
    
    var body: some View {
        Button {
            summaryScreenViewModel.houseState = .create
            createNewHouseShowing = true
        } label: {
            Text("Create New Household")
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(myrtleGreen)
                .cornerRadius(12)        }
    }
}


