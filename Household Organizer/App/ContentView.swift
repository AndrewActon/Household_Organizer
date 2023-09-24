//
//  ContentView.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/21/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    @EnvironmentObject var auth: AuthenticationModel
    @State private var displayName: String = ""
    
    // MARK: - Functions
    func checkDisplayName() {
        guard let user = auth.user?.displayName else {
            return
        }
        
        displayName = user
        return
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if displayName.isEmpty {
                BlankView()
                
                SetDisplayNameView(displayName: $displayName)
            } else {
                BlankView()
                
                Text(displayName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 80)
                    .padding()
            }
            
        }
        .background(backgroundGradient)
        .onAppear {
            checkDisplayName()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationModel())
    }
}
