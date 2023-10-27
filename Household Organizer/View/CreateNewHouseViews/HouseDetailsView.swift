//
//  HouseDetailsView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI

struct HouseDetailsView: View {
    @EnvironmentObject var viewModel: CreateNewHouseViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Name")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                TextField("Enter name of house", text: $viewModel.name)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding()
            
            Text("Occupants:")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
        }
        
    }
}

