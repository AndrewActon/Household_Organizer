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
    
    // MARK: - Functions
    func createNewHouse(name: String, occupants: String) {
        let house = Household(id: UUID(), occupants: [occupants], name: name)
        
        AppDelegate.db.collection("households").document()
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Name")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
//                        .frame(width: 80)
                        .padding()
                    TextField("Enter name of house", text: $name)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }
                .padding()
                
                HStack {
                    Text("Find Occupants")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
//                        .frame(width: 80)
                        .padding()
                    TextField("Enter name of occupant", text: $email)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                }
                .padding()
            }
            .padding(.vertical, 20)
            .background(midnightGreen)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            
            Button {
                //
            } label: {
                Text("Create New Household")
            }
            .font(.system(size: 16, weight: .bold))
            .padding()
            .foregroundColor(.white)
            .background(midnightGreen)
            .clipShape(Capsule())

        }
        .padding()
    }
}

struct CreateNewHouseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewHouseView()
    }
}
