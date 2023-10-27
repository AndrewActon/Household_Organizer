//
//  AuthenticationScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import SwiftUI



struct AuthenticationScreen: View {
    
    @ObservedObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        Group {
            if authenticationViewModel.authenticationState == .authenticated {
                HomeScreen()
            } else {
                LoginScreen()
            }
        }
        .environmentObject(authenticationViewModel)
    }
}

struct AuthenticationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationScreen()
    }
}
