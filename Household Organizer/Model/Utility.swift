//
//  Utility.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import Foundation

struct Utility {
    var name: String
    var payer: Payer
    var amount: Double
    var instructions: String
    var dueDate: Date
}

struct Payer {
    var name: String
    var payStatus: Bool
}
