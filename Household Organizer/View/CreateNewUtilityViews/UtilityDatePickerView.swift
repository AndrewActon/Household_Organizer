//
//  UtilityDatePickerView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 2/14/24.
//

import SwiftUI

struct UtilityDatePickerView: View {
    @EnvironmentObject var utilityDetailsViewModel: UtilityDetailsViewModel
    
    var body: some View {
        HStack {
            Text("Due Date:")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .padding()
            
            DatePicker("Due Date", selection: $utilityDetailsViewModel.dueDate, displayedComponents: .date)
                .labelsHidden()
                .foregroundStyle(.white)
                .colorInvert()
                .colorMultiply(.white)
            
            Image(systemName: "chevron.down")
                .foregroundStyle(.white)
            
        }
        .padding()
    }
}

#Preview {
    UtilityDatePickerView()
}
