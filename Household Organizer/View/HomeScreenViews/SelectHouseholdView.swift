//
//  SelectHouseholdView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/25/23.
//

import SwiftUI

struct SelectHouseholdView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: HomeScreenViewModel
    @Binding var createNewHouseShowing: Bool
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            HStack {
                
                Text("Select Household:")
                    .frame(width: geometry.size.width*0.3)
                    .font(.system(size: 12, weight: .light))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Spacer()
                    
                Group {
                    if viewModel.selectedHousehold == nil {
                        Text("Create A New Household")
                    } else if viewModel.households == nil {
                        Text((viewModel.selectedHousehold?.name)!)
                    } else {
                        Menu((viewModel.selectedHousehold?.name)!) {
                            ForEach(viewModel.households!, id: \.id) { house in
                                Button {
                                    viewModel.selectedHousehold = house
                                } label: {
                                    Text(house.name)
                                }
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width*0.3)
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                
                Spacer()
                
                Group {
                    Button {
                        createNewHouseShowing = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .background(myrtleGreen)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: geometry.size.width*0.3)
                
            }
            .background(myrtleGreen)
        }

        
    }
}
