//
//  AuthenticationScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

@MainActor class AuthenticationViewModel: ObservableObject {
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var user: UserModel = UserModel(id: "", email: "")
    private var firebaseUser: User? 
    
    func signUpWithEmailAndPassword(email: String, password: String) async -> UserModel {
            authenticationState = .authenticating
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                firebaseUser = authResult.user
                print("User \(authResult.user.uid)")
                authenticationState = .authenticated
                
                user.id = firebaseUser?.uid ?? ""
                user.name = firebaseUser?.displayName ?? ""
                user.email = firebaseUser?.email ?? ""
                
                return user
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                authenticationState = .unauthenticated
                return user
            }
        }
    
}
