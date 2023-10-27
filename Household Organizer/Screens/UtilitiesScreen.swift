//
//  UtilitiesScreen.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/20/23.
//

import SwiftUI

struct UtilitiesScreen: View {
    // MARK: - Properties
    @ObservedObject var viewModel = UtilitiesScreenViewModel()
    @State var createNewUtilityShowing: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                CreateUtilityButton(createNewUtilityShowing: $createNewUtilityShowing)
                
                
            }
            .background(backgroundGradient)
            .environmentObject(viewModel)
            
        }
        .sheet(isPresented: $createNewUtilityShowing) {
            
        }
    }
}

struct UtilitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        UtilitiesScreen()
    }
}
