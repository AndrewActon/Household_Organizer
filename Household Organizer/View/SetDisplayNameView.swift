//
//  SetDisplayNameView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/23/23.
//

import SwiftUI
import FirebaseFirestore

struct SetDisplayNameView: View {
    // MARK: - Properties
    @EnvironmentObject var auth: AuthenticationModel
    @State private var displayNameTextField: String = ""
    @Binding var displayName: String
    private var isButtonDisabled: Bool {
        displayNameTextField.isEmpty
    }
    
    // MARK: - Functions
    func createNewUser() {
        guard let authUser = auth.user else { return }
        let user = UserModel(id: authUser.uid, name: displayName, email: auth.email)
        
        AppDelegate.db.collection("Users").addDocument(data: [
            "id" : user.id,
            "name" : user.name,
            "email" : user.email
        ]) { error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            } else {
                print("Document added")
            }
        }
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
                createNewUser()
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

struct SetDisplayNameView_Previews: PreviewProvider {
    static var previews: some View {
        SetDisplayNameView(displayName: .constant(""))
            .previewLayout(.sizeThatFits)
            .environmentObject(AuthenticationModel())
            .background(backgroundGradient)
    }
}
