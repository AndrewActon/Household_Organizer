//
//  CreateNewUtilitySheet.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import SwiftUI

struct CreateNewUtilitySheet: View {
    // MARK: - Properties
    @EnvironmentObject var utilitiesScreenViewModel: UtilitiesScreenViewModel
    @ObservedObject var viewModel = CreateNewUtilityViewModel()
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            UtilityHeaderView()
            
            UtilityNameView()
        }
        .environmentObject(viewModel)
    }
}

struct CreateNewUtilitySheet_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewUtilitySheet(isShowing: .constant(true))
    }
}
