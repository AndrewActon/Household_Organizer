//
//  CreateNewHouseView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/25/23.
//

import SwiftUI

struct CreateNewHouseView: View {
    // MARK: - Properties
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var findingUser: Bool = false
    @Binding var isShowing: Bool
    private var isDisabled: Bool {
        name.isEmpty || email.isEmpty
    }
    
    // MARK: - Functions
    func createNewHouse(name: String, occupants: String) {
        let house = Household(id: UUID(), occupants: [occupants], name: name)
        
        AppDelegate.db.collection("households").addDocument(data: [
            "uuid" : house.id.uuidString,
            "occupants" : house.occupants,
            "name" : house.name
        ]) { error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            } else {
                print("Document added")
            }
        }
        
        isShowing = false
    }
    
    // MARK: - Body
    var body: some View {
        if findingUser {
            FindUserView(isShowing: $findingUser)
        } else {
            VStack {
                VStack {
                    HStack {
                        Text("Name")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                        TextField("Enter name of house", text: $name)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                    .padding()
                    
                    Button {
                        withAnimation {
                            findingUser = true                            
                        }
                    } label: {
                        Text("Find Occupants")
                    }
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(myrtleGreen)
                    .cornerRadius(12)
                    
                }
                .padding(.vertical, 20)
                .background(midnightGreen)
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
                
                Button {
                    createNewHouse(name: name, occupants: email)
                } label: {
                    Text("Create New Household")
                }
                .disabled(isDisabled)
                .font(.system(size: 16, weight: .bold))
                .padding()
                .foregroundColor(.white)
                .background(isDisabled ? .red : midnightGreen)
                .clipShape(Capsule())
                
            }
            .padding()
        }
    }
}

struct CreateNewHouseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewHouseView(isShowing: .constant(true))
    }
}
