//
//  UtilityInfoView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 12/20/23.
//

import SwiftUI

struct UtilityInfoView: View {
    @EnvironmentObject var createNewUtilityViewModel: UtilityDetailsViewModel
    @State var isRotated: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Enter name for utility", text: $createNewUtilityViewModel.name)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
            }
            
            HStack {
                Text("Total Cost: ")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding()
                
                TextField("0.00", value: $createNewUtilityViewModel.totalCost, format: .number)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                
            }
            
            HStack {
                Text("Due Date")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding()
                
                DatePicker("Due Date", selection: $createNewUtilityViewModel.dueDate, displayedComponents: .date)
                    .labelsHidden()
                    .foregroundStyle(.white)
                    .colorInvert()
                    .colorMultiply(.white)
                    .padding()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            isRotated.toggle()
                        }
                    }
                
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isRotated ? 180.00 : 0.00))
                    .foregroundStyle(.white)
                
            }
            
            Button {
                createNewUtilityViewModel.splitEvenly()
            } label: {
                Text("Split Evenly")
                    .padding()
            }
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.white)
            .background(myrtleGreen)
            .clipShape(Capsule())
        }
        .padding()
    }
}

