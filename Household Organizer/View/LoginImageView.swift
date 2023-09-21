//
//  LoginImageView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI

struct LoginImageView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
    }
}

struct LoginImageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginImageView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
