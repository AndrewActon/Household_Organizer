//
//  UtilityNameView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct UtilityNameView: View {
    
    @EnvironmentObject var viewModel: CreateNewUtilityViewModel
    
    var body: some View {
        HStack {
            Text("Name")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
            TextField("Enter name for utility", text: $viewModel.name)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
        }
        .padding()
    }
}
