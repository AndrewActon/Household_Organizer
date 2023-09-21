//
//  LoginView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            
            LoginImageView()
            
            Spacer()
            
            LoginDetailsView()
            
            Spacer()
            
        }
        .background(backgroundGradient)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
