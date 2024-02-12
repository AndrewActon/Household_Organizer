//
//  UtilityInstructionsField.swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/30/23.
//

import SwiftUI

struct UtilityInstructionsField: View {
    @EnvironmentObject var createNewUtilityViewModel: UtilityDetailsViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Input payement instructions and other details here: ")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
            
            TextEditor(text: $createNewUtilityViewModel.instructions)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.white)
                .scrollContentBackground(.hidden)
                .background(Color(UIColor.secondarySystemBackground))
                .padding(.horizontal, 12)
        }
    }
}
