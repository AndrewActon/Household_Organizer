//
//  HomeView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/24/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State private var household: String = "Andrew's"
    
    // MARK: - Body
    var body: some View {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()

                    GrocerySummaryView()
            }
    }//: Body
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
