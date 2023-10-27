//
//  CreateHouseButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct CreateHouseButton: View {
    
    @Binding var createNewHouseShowing: Bool
    
    var body: some View {
        Button {
            createNewHouseShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .foregroundColor(.white)
        }
    }
}

struct CreateHouseButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateHouseButton(createNewHouseShowing: .constant(true))
            .background(cambridgeGreen)
            .previewLayout(.sizeThatFits)
    }
}
