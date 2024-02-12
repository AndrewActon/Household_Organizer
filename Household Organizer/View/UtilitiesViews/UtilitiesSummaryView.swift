//
//  UtilitiesSummaryView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 11/27/23.
//

import SwiftUI

struct UtilitiesSummaryView: View {
    // MARK: - Properties
    @EnvironmentObject var utilitiesScreenViewModel: UtilitiesScreenViewModel
    @Binding var utilitiesSheetShowing: Bool
    @State var markPaidAlertIsShowing: Bool = false
    @State var utility: Utility
    
    var body: some View {
        ScrollView {
            
            VStack {
                //Header Section
                HStack {
                    Text(utility.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        utilitiesScreenViewModel.editID = utility.id
                        utilitiesScreenViewModel.utilityState = .edit
                        utilitiesSheetShowing = true
                    } label: {
                        Text("Edit")
                    }
                    .font(.system(size: 12, weight: .bold))
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                
                HStack {
                    Text("Due On: ")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text(utility.dueDate.formatted(.dateTime.day().month()))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                
                Divider()
                    .overlay(Color.white)
                
                //Occupants
                if utility.payStatus != nil {
                    ForEach(utility.payStatus!) { payStatus in
                        HStack {
                            Text(payStatus.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text("$\(payStatus.amount, specifier: "%.2f")")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text(payStatus.paid ? "Paid" : "Unpaid")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(payStatus.paid ? cambridgeGreen : .red)
                        }
                    }
                }
                
                Divider()
                    .overlay(Color.white)
                
                //Instructions
                HStack {
                    Spacer()
                    
                    Text("Payment Instructions: ")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                
                Text(utility.instructions)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                
                Divider()
                    .overlay(Color.white)
                
                Button {
                    markPaidAlertIsShowing = true
                } label: {
                    Text("Mark As Paid")
                }
                .font(.system(size: 12, weight: .bold))
                .padding()
                .background(myrtleGreen)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert("Mark your portion as paid", isPresented: $markPaidAlertIsShowing) {
                    Button("Mark paid", role: .none) {
                        Task {
                            let updatedUtility = await utilitiesScreenViewModel.markAsPaid(utility: utility)
                            self.utility = updatedUtility
                        }
                    }
                    
                    Button("Cancel", role: .cancel) { }
                }
                
            }
            .padding()
            .background(darkGreen)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 6)   
        }
        .padding()
        
    }
}
