//
//  GroceryView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/24/23.
//

import SwiftUI

struct GroceryView: View {
    var body: some View {
        VStack {
            ForEach(0..<10) { item in
                Text("Grocery Item")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(midnightGreen)
        .cornerRadius(12)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
    }
}

struct GroceryView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryView()
    }
}
