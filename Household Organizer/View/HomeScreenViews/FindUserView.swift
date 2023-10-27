//
//  FindUserView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/26/23.
//

import SwiftUI
import FirebaseFirestore

struct FindUserView: View {
    // MARK: - Properties
    @State private var searchNameTextField: String = ""
    @Binding var foundUser: UserModel?
    @Binding var isShowing: Bool
    private var isButtonDisabled: Bool {
        searchNameTextField.isEmpty
    }

    // MARK: - Functions
//    func findUser(email: String, completion: @escaping (UserModel) -> Void ) {
//        var user: UserModel = UserModel(id: "", name: "", email: "")
//
//        AppDelegate.db.collection("Users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
//            }
//
//            guard let snapshot = snapshot?.documents else { return completion(user)}
//
//            var snapshotUser: UserModel?
//
//            for document in snapshot {
//                 snapshotUser = UserModel(id: document["id"] as? String ?? "",
//                          name: document["name"] as? String ?? "",
//                          email: document["email"] as? String ?? "")
//            }
//
//            guard let newUser = snapshotUser else { return completion(user) }
//
//            user = newUser
//
//            return completion(user)
//        }
//    }



    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                Text("Enter User Email:")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()

                TextField("", text: $searchNameTextField)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)

                HStack {
                    Button {
//                        findUser(email: searchNameTextField) { user in
//                            foundUser = user
//                        }

//                        foundUser?.findUser(email: searchNameTextField)
                    } label: {
                        Text("Search for User")
                    }
                    .disabled(isButtonDisabled)
                    .padding()
                    .font(.headline)
                    .frame(width: 160)
                    .foregroundColor(.white)
                    .background(isButtonDisabled ? .red : myrtleGreen)
                    .cornerRadius(12)

                    Button {
                        isShowing = false
                    } label: {
                        Text("Cancel")
                    }
                    .padding()
                    .font(.headline)
                    .frame(width: 160)
                    .foregroundColor(.white)
                    .background(myrtleGreen)
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(midnightGreen)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)

            HStack {
                if foundUser != nil {
                    Text(foundUser?.name ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()

                    Button {
                        isShowing = false
                        print(foundUser)
                    } label: {
                        Text("Add user")
                    }
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(myrtleGreen)
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(midnightGreen)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
        }
        .padding()
    }
}

