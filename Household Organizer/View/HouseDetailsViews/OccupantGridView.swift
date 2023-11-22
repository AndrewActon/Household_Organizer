//
//  OccupantGridView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI

struct OccupantGridView: View {
    
    @EnvironmentObject var viewModel: HouseDetailsViewModel
    
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 12) {
            ForEach (viewModel.occupants, id: \.id) { occupant in
                Button {
                    viewModel.removeUserFromHousehold(user: occupant)
                } label: {
                    Text(occupant.name ?? occupant.email)

                    
                    Image(systemName: "x.circle")
                }
                .background(myrtleGreen)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
            }
        }
    }
}

