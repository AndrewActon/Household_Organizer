//
//  LoginDetailsView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct LoginDetailsView: View {
    // MARK: - Properties
    @EnvironmentObject var auth: AuthenticationModel
    @Binding var showCreateNewUser: Bool
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("Email")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 80)
                    .padding()
                TextField("Enter User Email", text: $auth.email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.trailing, 10)
            
            HStack {
                Text("Password")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 80)
                    .padding()
                TextField("Enter User Password", text: $auth.password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.trailing, 10)
            .padding(.bottom, 10)
            
            
            HStack {
                Spacer()
                    
                Button {
                    Task {
                        await auth.signInWithEmailAndPassword()
                    }
                } label: {
                    Text("Login")
                }
                    .frame(width: 80)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(myrtleGreen)
                    .cornerRadius(12)
                
                Spacer()
                
                Button {
                    showCreateNewUser = true
                } label: {
                    Text("Signup")
                }
                    .frame(width: 80)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(myrtleGreen)
                    .cornerRadius(12)
                
                Spacer()
            }
        }
    }
}

struct LoginDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginDetailsView(showCreateNewUser: .constant(true))
            .previewLayout(.sizeThatFits)
            .background(backgroundGradient)
            .environmentObject(AuthenticationModel())
    }
}
