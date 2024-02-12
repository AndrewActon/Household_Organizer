//
//  householdMenu.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct HouseholdMenu: View {
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State private var isRotated: Bool = false
    
    var body: some View {
        HStack {
            if loginScreenViewModel.selectedHousehold == nil {
                Spacer()
                
                Text("No Households Found")
                    .padding()
                
                Spacer()
            }  else if homeScreenViewModel.households == nil {
                Spacer()
                
                Text((loginScreenViewModel.selectedHousehold?.name)!)
                    .padding()
                
                Spacer()
            } else {
                HStack {
                    Menu {
                        ForEach(homeScreenViewModel.households!, id: \.id) { house in
                            Button {
                                loginScreenViewModel.selectedHousehold = house
                                withAnimation(.easeOut) {
                                    isRotated.toggle()
                                }
                            } label: {
                                Text(house.name)
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text(loginScreenViewModel.selectedHousehold?.name ?? "")
                            
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(isRotated ? 180.00 : 0.00))
                            
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            isRotated.toggle()
                        }
                    }
                    .padding()
                }
            }
        }
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(.white)
    }
}

