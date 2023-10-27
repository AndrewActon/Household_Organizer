//
//  UtilitiesScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import Foundation

@MainActor class UtilitiesScreenViewModel: ObservableObject {
    // MARK: - Properties
    @Published var utilities: [Utility] = []

}
