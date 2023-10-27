////
////  ContentView.swift
////  Household Organizer
////
////  Created by Andrew Acton on 9/21/23.
////
//
//import SwiftUI
//import CoreData
//import FirebaseAuth
//
//struct ContentView: View {
//    // MARK: - Properties
//    @EnvironmentObject var auth: AuthenticationModel
////    @StateObject var household = Household(id: "", occupants: [], name: "")
//    @StateObject private var user: UserModel = UserModel(id: "", name: "", email: "")
//    @State private var displayName: String = ""
//    @State private var showCreateNewHouse: Bool = false
//    
//    // MARK: - Body
//    var body: some View {
//        Group {
//            if displayName.isEmpty {
//                ZStack {
//                    BlankView()
//                    
//                    SetDisplayNameView(displayName: $displayName)
//                        .onDisappear{
//                            user.name = displayName
//                        }
//                }
//            } else {
//                ZStack {
//                    VStack {
//                        SelectHouseholdView(createNewHouseShowing: $showCreateNewHouse)
//                        
//                        
//                        TabView {
//                            HomeView()
//                                .tabItem {
//                                    Label("Home", systemImage: "house.fill")
//                                }
//                                .toolbarBackground(night, for: .tabBar)
//                                .toolbarBackground(.visible, for: .tabBar)
//                            
//                            GroceryView()
//                                .tabItem {
//                                    Label("Groceries", systemImage: "basket.fill")
//                                }
//                                .toolbarBackground(night, for: .tabBar)
//                                .toolbarBackground(.visible, for: .tabBar)
//                        }
//                    }
//                    .background(myrtleGreen)
//                    .blur(radius: showCreateNewHouse ? 8.0 : 0, opaque: false)
//                    
//                    if showCreateNewHouse {
//                        BlankView()
//                            .onTapGesture {
//                                withAnimation {
//                                    showCreateNewHouse = false
//                                }
//                            }
//                        
//                        CreateNewHouseView(isShowing: $showCreateNewHouse)
//                    }
//                }
//            }
//        }
//        .background(backgroundGradient)
//        .onAppear {
//            let foundUser = user.findUser(email: auth.email)
//            
//            user.id = foundUser.id
//            user.name = foundUser.name
//            user.email = foundUser.email
//            
//            guard let name = user.name else { return }
//            
//            displayName = name
//        }
//    }//: Body
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AuthenticationModel())
//    }
//}
