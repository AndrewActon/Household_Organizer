//
//  CreateUtilityButton.swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/30/23.
//

import SwiftUI

struct CreateNewUtilityButton: View {
    @EnvironmentObject var loginScreenViewModel: LoginScreenViewModel
    @EnvironmentObject var utilitiesDetailsViewModel: UtilityDetailsViewModel
    @State private var isDisabled: Bool = false
    @Binding var isShowing: Bool
    
    var body: some View {
        switch utilitiesDetailsViewModel.utilityState {
        case .create:
            Button {
                guard let household = utilitiesDetailsViewModel.createNewUtility() else { return }
                
                loginScreenViewModel.selectedHousehold = household
                
                isShowing = false
            } label: {
                Text("Create")
                    .padding()
            }
            .foregroundStyle(.white)
            .background(isDisabled ? .red : myrtleGreen)
            .clipShape(Capsule())
        case .edit:
            HStack {
                Button {
                    utilitiesDetailsViewModel.updateUtility()
                    
                    isShowing = false
                } label: {
                    Text("Edit")
                        .padding()
                }
                .foregroundStyle(.white)
                .background(isDisabled ? .red : myrtleGreen)
                .clipShape(Capsule())
                
                Button {
                    utilitiesDetailsViewModel.alertIsShowing = true
                } label: {
                    Text("Delete Utility")
                        .padding()
                }
                .foregroundStyle(.white)
                .background(.red)
                .clipShape(Capsule())
                .alert("Are you sure you want to delete this utility bill?", isPresented: $utilitiesDetailsViewModel.alertIsShowing) {
                    Button("Delete", role: .destructive) {
                        Task {
                            guard let household = await utilitiesDetailsViewModel.deleteUtility() else { return }
                            
                            loginScreenViewModel.selectedHousehold = household
                            
                            isShowing = false
                        }
                    }
                    
                    Button("Dismiss", role: .cancel) { }
                }
                
            }
            
        case .none:
            Button {
                isShowing = false
            } label: {
                Text("Error")
                    .padding()
            }
            .foregroundStyle(.white)
            .clipShape(Capsule())
        }
    }
}

