//
//  SelectHouseholdView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/25/23.
//

import SwiftUI

struct SelectHouseholdView: View {
    // MARK: - Properties
    @State private var household: String = ""
    @State private var households: [Household] = []
    @Binding var createNewHouseShowing: Bool
    
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            
            Picker("Select Household", selection: $household) {
                if households.isEmpty {
                    Text("Create a household")
                    
                }
                ForEach(households) { listhouse in
                    Text(listhouse.name)
                        .tag(listhouse.name)
                }
            }
            
            Button {
                createNewHouseShowing = true
            } label: {
                Image(systemName: "plus.circle")
                    .background(myrtleGreen)
                    .foregroundColor(.white)
            }
            
            
            Spacer()
        }
        .background(myrtleGreen)
    }
}

struct SelectHouseholdView_Previews: PreviewProvider {
    static var previews: some View {
        SelectHouseholdView(createNewHouseShowing: .constant(true))
    }
}
