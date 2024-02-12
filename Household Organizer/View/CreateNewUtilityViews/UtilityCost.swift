//
//  UtilityCost().swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/29/23.
//

import SwiftUI

struct UtilityCost: View {
    @EnvironmentObject var createNewUtilityViewModel: CreateNewUtilityViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Total Cost: ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding()
                
                TextField("0.0", value: $createNewUtilityViewModel.totalCast, format: .number)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                
            }
            .padding()
            
            Button {
                createNewUtilityViewModel.splitEvenly()
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
}
