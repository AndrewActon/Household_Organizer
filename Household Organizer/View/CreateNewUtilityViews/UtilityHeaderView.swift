//
//  UtilityHeaderView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct UtilityHeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("Create A New Utility Bill")
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.white)
                .padding()
            
            Spacer()
        }
    }
}

struct UtilityHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UtilityHeaderView()
            .background(backgroundGradient)
    }
}
