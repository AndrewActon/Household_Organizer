//
//  UtilityInfoView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 12/20/23.
//

import SwiftUI

struct UtilityInfoView: View {
    @EnvironmentObject var createNewUtilityViewModel: UtilityDetailsViewModel
    @State var isRotated: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Enter name for utility", text: $createNewUtilityViewModel.name)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            
            HStack {
                Text("Total Cost: ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding()
                
                TextField("0.00", value: $createNewUtilityViewModel.totalCost, format: .number)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .keyboardType(.decimalPad)
                
            }
            .padding()
            
        }
        .padding()
    }
    
}

