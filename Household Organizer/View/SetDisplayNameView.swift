//
//  SetDisplayNameView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/23/23.
//

import SwiftUI

struct SetDisplayNameView: View {
    // MARK: - Properties
    @EnvironmentObject var auth: AuthenticationModel
    @State private var displayNameTextField: String = ""
    @Binding var displayName: String
    private var isButtonDisabled: Bool {
        displayNameTextField.isEmpty
    }
    
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
                    await auth.updateUserName(name: displayName)
                }
                displayName = displayNameTextField
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
    }
}

struct SetDisplayNameView_Previews: PreviewProvider {
    static var previews: some View {
        SetDisplayNameView(displayName: .constant(""))
            .previewLayout(.sizeThatFits)
            .environmentObject(AuthenticationModel())
            .background(backgroundGradient)
    }
}
