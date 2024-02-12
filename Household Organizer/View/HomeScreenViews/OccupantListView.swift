//
//  OccupantListView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/27/24.
//

import SwiftUI

struct OccupantListView: View {
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var occupantIDs: [String]
    @State var occupants: [UserModel] = []
    
    var body: some View {
        List {
            ForEach(occupants) { occupant in
                HStack {
                    Text(occupant.name ?? "")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        guard let house = homeScreenViewModel.removeOccupantFromHousehold(userID: occupant.id, household: loginScreenViewModel.selectedHousehold) else { return }
                        
                        loginScreenViewModel.selectedHousehold = house
                    } label: {
                        Text("Remove Occupant")
                            .padding()
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .background(.red)
                            .clipShape(Capsule())
                    }
                }
            }
            .listRowBackground(myrtleGreen)
            
            
        }
        .scrollContentBackground(.hidden)
        
        
        .task {
            var users: [UserModel] = []
            
            for id in occupantIDs {
                guard let user = await UserManager.shared.findUserByID(userID: id) else { return }
                
                users.append(user)
            }
            
            occupants = users
        }
        
    }
}
