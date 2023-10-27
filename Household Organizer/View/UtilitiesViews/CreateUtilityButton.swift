//
//  CreateUtilityButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct CreateUtilityButton: View {
    
    @Binding var createNewUtilityShowing: Bool
    
    var body: some View {
        Button {
            createNewUtilityShowing = true
        } label: {
            Text("Create New Utility Bill")
        }
        .font(.system(size: 16, weight: .bold))
        .padding()
        .background(myrtleGreen)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct CreateUtilityButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateUtilityButton(createNewUtilityShowing: .constant(false))
    }
}
