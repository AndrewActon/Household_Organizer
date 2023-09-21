//
//  LoginDetailsView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI

struct LoginDetailsView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @State private var email: String = ""
    @State private var password: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("Email: ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 100)
                    .padding()
                TextField("Enter User Email", text: $email)
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
            }
            
            HStack {
                Text("Password: ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 100)
                    .padding()
                TextField("Enter User Password", text: $password)
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
            }
            
            HStack {
                Spacer()
                
                Button {
                    //
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
                    //
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
        LoginDetailsView()
            .previewLayout(.sizeThatFits)
            .background(backgroundGradient)
    }
}
