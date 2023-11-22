//
//  householdMenu.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct HouseholdMenu: View {
    
    @EnvironmentObject var viewModel: SummaryScreenViewModel
    
    var body: some View {
        HStack {
            if viewModel.selectedHousehold == nil {
                Text("No Households Found")
            } else if viewModel.households == nil {
                Text((viewModel.selectedHousehold?.name)!)
            } else {
                HStack {
                    Menu((viewModel.selectedHousehold?.name)!) {
                        ForEach(viewModel.households!, id: \.id) { house in
                            Button {
                                viewModel.selectedHousehold = house
                            } label: {
                                Text(house.name)
                            }
                        }
                    }
                    
                    Image(systemName: "chevron.down")
                    
                }
            }
        }
        .font(.system(size: 16, weight: .bold))
        .foregroundColor(.white)
    }
}

struct HouseholdMenu_Previews: PreviewProvider {
    static var previews: some View {
        HouseholdMenu()
            .background(backgroundGradient)
            .environmentObject(HomeScreenViewModel())
            .environmentObject(SummaryScreenViewModel())
    }
}
