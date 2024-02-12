//
//  HeaderView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var viewModel: HouseDetailsViewModel
    
    var body: some View {
        if viewModel.houseState == .create {
            HStack {
                Spacer()
                
                Text("Create A New Household")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
            }
        }
        
        if viewModel.houseState == .edit {
            HStack {
                Spacer()
                
                Text("Edit Household")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
            }
        }
    }
}
