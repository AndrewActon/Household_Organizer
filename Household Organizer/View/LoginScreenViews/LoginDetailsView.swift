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
    @EnvironmentObject var login: LoginScreenViewModel
    @Binding var email: String
    @Binding var password: String
    @Binding var showCreateNewUser: Bool
    @State var signInError: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("Email")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 80)
                    .padding()
                TextField("Enter User Email", text: $email)
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
                SecureField("Enter User Password", text: $password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            .padding(.trailing, 10)
            .padding(.bottom, 10)
            
            Text(signInError ? "Incorrect email or password" : "")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.red)
                .padding()
            
            HStack {
                Spacer()
                    
                Button {
                    Task {
                        let error = await login.signInWithEmailAndPassword(email: email, password: password)
                        
                        if !error {
                            signInError = true
                        }
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
                    Text("Sign Up")
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
