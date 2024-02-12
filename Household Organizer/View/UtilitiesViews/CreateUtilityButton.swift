//
//  CreateUtilityButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct CreateUtilityButton: View {
    
    @Binding var createNewUtilityShowing: Bool
    @EnvironmentObject var utilitiesScreenViewModel: UtilitiesScreenViewModel
    
    var body: some View {
        Button {
            createNewUtilityShowing = true
            utilitiesScreenViewModel.utilityState = .create
        } label: {
            Text("Create New Utility Bill")
        }
        .font(.system(size: 16, weight: .bold))
        .padding()
        .background(myrtleGreen)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

