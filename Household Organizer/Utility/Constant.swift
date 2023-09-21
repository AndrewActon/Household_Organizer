//
//  Constant.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI

// MARK: - Strings
let cambridgeGreen: Color = Color("cambridgeGreen")
let darkGreen: Color = Color("darkGreen")
let midnightGreen: Color = Color("midnightGreen")
let myrtleGreen: Color = Color("myrtleGreen")
let night: Color = Color("night")

// MARK: - UI
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [cambridgeGreen, night]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
