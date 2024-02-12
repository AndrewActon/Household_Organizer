//
//  LoginScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var loginViewModel = LoginScreenViewModel()
    @ObservedObject var homeScreenViewModel = HomeScreenViewModel()
    @State private var showCreateNewUser: Bool = false
    
    var body: some View {
        NavigationView {
            if loginViewModel.authenticationState == .authenticated {
                VStack {
                    TabView {
                        HomeScreen()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                            .toolbarBackground(night, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
                        UtilitiesScreen()
                            .tabItem {
                                Label("Utilities", systemImage: "bolt.fill")
                            }
                            .toolbarBackground(night, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
                        SettingsScreen()
                            .tabItem {
                                Label("Settings", systemImage: "gear")
                            }
                            .toolbarBackground(night, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
                    }
                }
                
                .task {
                    guard let household = await homeScreenViewModel.setupView() else { return }
                    
                    loginViewModel.selectedHousehold = household
                }
            } else {
                ZStack {
                    VStack {
                        LoginImageView()
                        
                        Spacer()
                        
                        LoginDetailsView(email: $loginViewModel.email, password: $loginViewModel.password, showCreateNewUser: $showCreateNewUser)
                        
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
        .environmentObject(homeScreenViewModel)

    }
}

