//
//  CreateNewHouseView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/25/23.
//

import SwiftUI

struct HouseDetailsSheet: View {
    // MARK: - Properties
    @ObservedObject var createNewHouseViewModel = HouseDetailsViewModel()
    @Binding var isShowing: Bool
    private var createButtonIsDisabled: Bool {
        createNewHouseViewModel.name.isEmpty || createNewHouseViewModel.occupants.isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            HeaderView()
            
            HouseDetailsView()
            
            OccupantGridView()
            
            SearchForUserView()
            
            Spacer()
            
            Button {
                createNewHouseViewModel.createNewHouse(name: createNewHouseViewModel.name, occupants: createNewHouseViewModel.occupants)

                isShowing = false
            } label: {
                Text("Create")
            }
            .disabled(createButtonIsDisabled)
            .font(.system(size: 16, weight: .bold))
            .padding()
            .foregroundColor(.white)
            .background(createButtonIsDisabled ? .red : myrtleGreen)
            .clipShape(Capsule())
            
        }
        .padding()
        .background(backgroundGradient)
        .environmentObject(createNewHouseViewModel)
    }
    
}

#Preview {
    HouseDetailsSheet(createNewHouseViewModel: HouseDetailsViewModel(), isShowing: .constant(true))
}
