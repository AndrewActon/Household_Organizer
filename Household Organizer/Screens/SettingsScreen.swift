//
//  SettingsScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 1/24/24.
//

import SwiftUI

struct SettingsScreen: View {
    @StateObject var settingsScreenViewModel = SettingsScreenViewModel()
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    
    var body: some View {
        ZStack {
            BlankView()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("\(UserManager.shared.user.name ?? "")'s: Settings")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                .background(cambridgeGreen)
                
                Spacer()
                
                Button {
                    settingsScreenViewModel.signOut()
                } label: {
                    Text("Sign Out")
                        .font(.system(size: 12, weight: .bold))
                        .padding()
                        .background(myrtleGreen)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
                Button {
                    settingsScreenViewModel.deleteAccount(userID: UserManager.shared.user.id)
                    loginScreenViewModel.deleteAccount()
                } label: {
                    Text("Delete Account")
                        .font(.system(size: 12, weight: .bold))
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .frame(width: 100)
                }
                .padding()
                
                Spacer()
            }
            
        }
        .background(backgroundGradient)
    }
}
