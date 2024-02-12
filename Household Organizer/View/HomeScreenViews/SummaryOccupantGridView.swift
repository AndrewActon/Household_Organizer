//
//  SummaryOccupantGridView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/4/24.
//

import SwiftUI

struct SummaryOccupantGridView: View {
    @State private var gridOccupants: [UserModel] = []
    
    let household: Household
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]
    
    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 12) {
            ForEach(gridOccupants, id: \.id) { occupant in
                Text(occupant.name ?? "")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .task {
            let occupants = household.occupants
            for occupant in occupants {
                guard let user = await UserManager.shared.findUserByID(userID: occupant) else { return }
                gridOccupants.append(user)
            }
        }
        
    }

}
