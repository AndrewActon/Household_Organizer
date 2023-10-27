//
//  HomeScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import SwiftUI

struct HomeScreen: View {
    // MARK: - Properties
    @EnvironmentObject var loginViewModel: LoginScreenViewModel
    @ObservedObject var viewModel = HomeScreenViewModel()
    @State private var createNewHouseShowing: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                if viewModel.user.name == "" {
                    ZStack {
                        BlankView()
                        
                        SetDisplayNameView()
                    }
                    .background(backgroundGradient)
                } else {
                    TabView {
                        SummaryScreen()
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
                    }
                }
            }
            .toolbarBackground(cambridgeGreen, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        HouseholdMenu()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    CreateHouseButton(createNewHouseShowing: $createNewHouseShowing)
                }
                
                
            }
            
            .sheet(isPresented: $createNewHouseShowing) {
                CreateNewHouseSheet(isShowing: $createNewHouseShowing)
                    .onDisappear {
                        Task {
                            viewModel.households = await viewModel.findUserHouseholds(user: viewModel.user)
                        }
                        createNewHouseShowing = false
                    }
            }
            
            .onAppear {
                viewModel.user = loginViewModel.user
                Task {
                    viewModel.households = await viewModel.findUserHouseholds(user: viewModel.user)
                }
            }
            .environmentObject(viewModel)
        }

    }
}

struct HomeScreenPreview: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
