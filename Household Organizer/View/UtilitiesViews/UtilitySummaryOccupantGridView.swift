//
//  UtilitySummaryOccupantGridView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/17/24.
//

import SwiftUI

struct UtilitySummaryOccupantGridView: View {
    @EnvironmentObject var utilitiesScreenViewModel: UtilitiesScreenViewModel
    @State private var user: UserModel?
    @State var payStatus: PayStatus
    
    var body: some View {
        HStack {
            Text(user?.name ?? "Username not found")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            Text("\(payStatus.amount, specifier: "%.2f")")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            Text(payStatus.paid ? "Paid" : "Unpaid" )
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
            
        }
        .task {
            guard let user = await utilitiesScreenViewModel.findUserWithPayStatus(status: payStatus) else { return }
            
            self.user = user
        }
        
    }
    
}

