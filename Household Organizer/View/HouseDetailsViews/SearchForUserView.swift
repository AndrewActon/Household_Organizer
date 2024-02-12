//
//  SearchForUserView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/26/23.
//

import SwiftUI

struct SearchForUserView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: HouseDetailsViewModel
    @State private var email: String = ""
    @State private var foundUser: UserModel?
    @State private var isAlertShowing: Bool = false
    private var searchButtonIsDisabled: Bool {
        email.isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                TextField("Enter email of occupant", text: $email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                
                Button {
                    Task {
                        await foundUser = viewModel.searchForUserByEmail(email: email)
                        if foundUser == nil {
                            isAlertShowing = true
                        }
                    }
                } label: {
                    Text("Search")
                }
                .disabled(searchButtonIsDisabled)
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.white)
                .background(searchButtonIsDisabled ? .red : myrtleGreen)
                .clipShape(Capsule())
            }
            .padding()
            .alert("No user found with that email.", isPresented: $isAlertShowing) {
                Button("Dismiss", role: .cancel) {
                    isAlertShowing = false
                }
            }
            
            if foundUser != nil {
                HStack {
                    Text("Click to add: ")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    Button {
                        viewModel.occupants.append(foundUser!)
                        email = ""
                        foundUser = nil
                    } label: {
                        Text((foundUser?.name)!)
                    }
                    .font(.system(size: 16, weight: .bold))
                    .padding()
                    .background(myrtleGreen)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                
            } else {
                Button {
                    //
                } label: {
                    Text("")
                }
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }

    }
}

