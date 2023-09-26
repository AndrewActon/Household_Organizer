//
//  ContentView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    @EnvironmentObject var auth: AuthenticationModel
    @State private var displayName: String = "Andrew"
    @State private var showCreateNewHouse: Bool = false
    
    // MARK: - Functions
    func checkDisplayName() {
        guard let user = auth.user?.displayName else {
            return
        }
        
        displayName = user
        return
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if displayName.isEmpty {
                ZStack {
                    BlankView()
                    
                    SetDisplayNameView(displayName: $displayName)
                }
            } else {
                ZStack {
                    VStack {
                        SelectHouseholdView(createNewHouseShowing: $showCreateNewHouse)
                        
                        TabView {
                            HomeView()
                                .tabItem {
                                    Label("Home", systemImage: "house.fill")
                                }
                                .toolbarBackground(night, for: .tabBar)
                                .toolbarBackground(.visible, for: .tabBar)
                            
                            GroceryView()
                                .tabItem {
                                    Label("Groceries", systemImage: "basket.fill")
                                }
                                .toolbarBackground(night, for: .tabBar)
                                .toolbarBackground(.visible, for: .tabBar)
                        }
                    }
                    .background(myrtleGreen)
                    .blur(radius: showCreateNewHouse ? 8.0 : 0, opaque: false)
                    
                    if showCreateNewHouse {
                        BlankView()
                            .onTapGesture {
                                withAnimation {
                                    showCreateNewHouse = false
                                }
                            }
                        
                        CreateNewHouseView()
                    }
                }
            }
        }
        .background(backgroundGradient)
        .onAppear {
            checkDisplayName()
        }
    }//: Body
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationModel())
    }
}
