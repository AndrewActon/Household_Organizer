//
//  User.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/26/23.
//

import Foundation

struct UserModel {
    // MARK: - Properties
    let id: String
    let name: String?
    let email: String
    
    // MARK: - Initializer
    init(id: String, name: String?, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
}
