//
//  HouseholdSummaryView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/16/23.
//

import SwiftUI

struct HouseholdSummaryView: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var summaryScreenViewModel: SummaryScreenViewModel
    @Binding var houseDetailsShowing: Bool
    
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
//        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            if homeScreenViewModel.households == nil {
                BlankView()
            } else {
                ForEach(homeScreenViewModel.households! , id: \.id) { house in
                    VStack {
                        HStack {
                            Text(house.name)
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Button {
                                summaryScreenViewModel.houseState = .edit
                                homeScreenViewModel.selectedHousehold = house
                                houseDetailsShowing = true
                            } label: {
                                Text("edit")
                            }
                            .padding()
                            .font(.headline)
                            .foregroundStyle(.white)
                            .background(.red)
                            .clipShape(Capsule())
                        }
                        .padding()
                        
                        Divider()
                            .overlay(Color.white)
                        
                        HStack {
                            Spacer()
                            
                            Text("Occupants")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Spacer()
                        }
                        
                        LazyVGrid(columns: gridColumns, content: {
                            ForEach(house.occupants, id: \.id) { occupant in
                                Text(occupant.name ?? occupant.email)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        })

                    }
                    .background(darkGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    .shadow(radius: 12.0)
                    
                }
                
                
            }
            
        }
        .padding()
    }
}
