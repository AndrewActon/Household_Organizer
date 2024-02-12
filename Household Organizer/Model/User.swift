//
//  User.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/26/23.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: String
    var name: String?
    var email: String
}


