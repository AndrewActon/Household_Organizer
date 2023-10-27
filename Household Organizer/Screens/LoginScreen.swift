//
//  LoginScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var loginViewModel = LoginScreenViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showCreateNewUser: Bool = false
    
    var body: some View {
        Group {
            if loginViewModel.authenticationState == .authenticated {
                HomeScreen()
            } else {
                ZStack {
                    VStack {
                        LoginImageView()
                        
                        Spacer()
                        
                        LoginDetailsView(email: $email, password: $password, showCreateNewUser: $showCreateNewUser)
                        
                        Spacer()
                    }
                    .background(backgroundGradient)
                    .blur(radius: showCreateNewUser ? 8.0 : 0, opaque: false)
                
                    if showCreateNewUser {
                        BlankView()
                            .onTapGesture {
                                withAnimation {
                                    showCreateNewUser = false
                                }
                            }
                        
                        CreateUserView(isShowing: $showCreateNewUser)
                    }
                        
                }
                
            }
        }
        .environmentObject(loginViewModel)

    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
