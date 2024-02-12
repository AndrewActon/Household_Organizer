//
//  Utility.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/27/23.
//

import Foundation

struct Utility: Codable, Identifiable {
    var id: String
    var name: String
    var amount: Double
    var instructions: String
    var dueDate: Date
    var payStatus: [PayStatus]?
}

struct PayStatus: Codable, Identifiable {
    var id: String
    var name: String
    var amount: Double
    var paid: Bool
}
