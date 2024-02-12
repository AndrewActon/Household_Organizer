//
//  HouseDetailsView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI

struct HouseDetailsView: View {
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var houseDetailsViewModel: HouseDetailsViewModel
    
    var body: some View {
        if houseDetailsViewModel.houseState == .create {
            VStack(alignment: .leading) {
                HStack {
                    Text("Name")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    TextField("Enter name of house", text: $houseDetailsViewModel.name)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }
                .padding()
                
                Text("Occupants:")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
            }
        }
        
        if houseDetailsViewModel.houseState == .edit {
            VStack(alignment: .leading) {
                HStack {
                    Text("Name")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    TextField(loginScreenViewModel.selectedHousehold?.name ?? "Enter name of house", text: $houseDetailsViewModel.name)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }
                .padding()
                
                Text("Occupants:")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
            }

        }
        
    }
}

