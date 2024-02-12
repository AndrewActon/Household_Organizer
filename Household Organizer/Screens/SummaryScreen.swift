//
//  SummaryScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/20/23.
//

import SwiftUI

//struct SummaryScreen: View {
//    // MARK: - Properties
//    @EnvironmentObject var loginViewModel: LoginScreenViewModel
//    @StateObject var summaryScreenViewModel = SummaryScreenViewModel()
//    @State private var houseDetailsShowing: Bool = false
    
//    var body: some View {
//        VStack {
//            
//            CreateHouseButton(createNewHouseShowing: $houseDetailsShowing)
//                .padding()
//            
//            VStack {
//                HouseholdSummaryView(houseDetailsShowing: $houseDetailsShowing)
//            }
//            
//            Spacer()
//        }
//        .environmentObject(summaryScreenViewModel)
//        .background(backgroundGradient)
//        .onAppear {
//            Task {
//                let house = await summaryScreenViewModel.findUserHouseholds(user: loginViewModel.user)
//                summaryScreenViewModel.households = house
//            }
//        }
//        
//        .sheet(isPresented: $houseDetailsShowing) {
//            HouseDetailsSheet(isShowing: $houseDetailsShowing, houseState: summaryScreenViewModel.houseState!)
//                .onDisappear {
//                    Task {
//                        summaryScreenViewModel.households = await summaryScreenViewModel.findUserHouseholds(user: loginViewModel.user)
//                    }
//                    houseDetailsShowing = false
//                }
//        }
//
//    }
//}

