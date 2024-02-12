//
//  OccupantsList.swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/29/23.
//

import SwiftUI

struct OccupantsList: View {
    @EnvironmentObject var createNewUtilityViewModel: UtilityDetailsViewModel
    @State var occupant: UserModel?
    let payStatus: PayStatus
    
    var body: some View {
            HStack {
                Text(occupant?.name ?? "")
                
                Spacer()
                
                TextField("", text: Binding(get: {
                    guard let user = occupant else { return "" }
                    
                    let amount = createNewUtilityViewModel.getAmount(userID: user.id)
                    
                    let stringAmount = String(amount)
                    
                    return stringAmount
                }, set: { amount in
                    guard let amount = Double(amount),
                          let occupant = occupant
                    else { return }
                    
                    self.createNewUtilityViewModel.setAmount(userID: occupant.id, amount: amount)
                }))
                    .padding()
                    .foregroundStyle(.white)
                    .fontWeight(.regular)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                
                Spacer()
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.white)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding()
            .task {
                guard let user = await createNewUtilityViewModel.findUser(userID: payStatus.id) else { return }
                self.occupant = user
            }
    }
}
    
    
