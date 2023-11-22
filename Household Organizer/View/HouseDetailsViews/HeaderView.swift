//
//  HeaderView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("Create A New Household")
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.white)
                .padding()
            
            Spacer()
        }
    }
}
