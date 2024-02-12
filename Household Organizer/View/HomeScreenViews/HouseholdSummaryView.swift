//
//  HouseholdSummaryView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/16/23.
//

import SwiftUI

struct HouseholdSummaryView: View {
    // MARK: - Properties
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Binding var houseDetailsShowing: Bool
    
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            if homeScreenViewModel.households == nil {
                BlankView()
            } else {
                ForEach(homeScreenViewModel.households!, id: \.id) { house in
                    VStack {
                        //Header Section
                        HStack {
                            //House Name
                            Text(house.name)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            //Edit Button
                            Button {
//                                homeScreenViewModel.setSelectedHousehold(household: house)
                                homeScreenViewModel.houseState = .edit
                                houseDetailsShowing = true
                            } label: {
                                Text("Edit")
                            }
                            .font(.system(size: 12, weight: .bold))
                            .padding()
                            .background(.red)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                        
                        Divider()
                            .overlay(Color.white)
                        
                        //Occupant Section
                        
                        //Title
                        HStack {
                            Spacer()
                            
                            Text("Occupants")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Spacer()
                        }
                        
                        //Occupant Name Grid
                        SummaryOccupantGridView(household: house)
                        
                        Divider()
                            .overlay(Color.white)
                    }
                    
                    
                }
                .padding()
                .background(darkGreen)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 6)
                
            }
        }
        .padding()
        
    }
}
