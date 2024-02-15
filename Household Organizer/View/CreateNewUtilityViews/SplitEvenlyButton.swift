//
//  SplitEvenlyButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 2/14/24.
//

import SwiftUI

struct SplitEvenlyButton: View {
    @EnvironmentObject var utilityDetailsViewModel: UtilityDetailsViewModel
    
    var body: some View {
        Button {
            utilityDetailsViewModel.splitEvenly()
        } label: {
            Text("Split Evenly")
                .padding()
        }
        .font(.system(size: 15, weight: .bold))
        .foregroundStyle(.white)
        .background(myrtleGreen)
        .clipShape(Capsule())
        
    }
}

#Preview {
    SplitEvenlyButton()
}
