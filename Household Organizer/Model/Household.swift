//
//  Household.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/25/23.
//

import Foundation

struct Household: Codable {
    var id: String
    var name: String
    var occupants: [String]
    var utilities: [String]?
}

