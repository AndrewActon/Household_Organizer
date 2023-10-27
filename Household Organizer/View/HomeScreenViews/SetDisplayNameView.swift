//
//  SetDisplayNameView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/23/23.
//

import SwiftUI

struct SetDisplayNameView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: HomeScreenViewModel
    @State var displayNameTextField: String = ""
    private var isButtonDisabled: Bool {
        displayNameTextField.isEmpty
    }
    
//    // MARK: - Functions

    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Enter a display name:")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
            TextField("Display Name", text: $displayNameTextField)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
            
            Button {
                Task {
                    await viewModel.updateUserName(name: displayNameTextField)
                }
            } label: {
                Text("Set Display Name")
            }
            .disabled(isButtonDisabled)
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .background(isButtonDisabled ? Color.red : myrtleGreen)
            .cornerRadius(12)
        }
        .padding()
    }
}
