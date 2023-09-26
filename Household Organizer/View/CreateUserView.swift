//
//  CreateUserView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/22/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct CreateUserView: View {
    
    // MARK: - Properties
    @EnvironmentObject var auth: AuthenticationModel
    @State private var createUserError: String = ""
    @Binding var isShowing: Bool
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(createUserError)
                .foregroundColor(.red)
                .font(.system(size: 16, weight: .bold))
            
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
            }
            .padding(.vertical, 20)
            .background(midnightGreen)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            
            Group {
                Button {
                    if auth.email.isEmpty {
                        createUserError = "Please enter an email."
                    } else if auth.password.isEmpty {
                        createUserError = "Please enter a password."
                    } else {
                        Task {
                            await auth.signUpWithEmailAndPassword()
                        }
                        withAnimation {
                            isShowing = false
                        }
                    }
                } label: {
                    Text("Create Account")
                }
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.white)
                .background(midnightGreen)
                .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding()
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView(isShowing: .constant(true))
            .background(backgroundGradient)
            .environmentObject(AuthenticationModel())
    }
}
