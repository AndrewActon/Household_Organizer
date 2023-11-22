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

struct SearchForUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchForUserView()
            .background(backgroundGradient)
    }
}
