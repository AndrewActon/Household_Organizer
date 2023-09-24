//
//  AuthenticationModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 9/22/23.
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

@MainActor class AuthenticationModel: ObservableObject {
    // MARK: - Properties
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var user: User?
    
    // MARK: - Initializer
    
    init(email: String = "", password: String = "", authenticationState: AuthenticationState = .unauthenticated, user: User? = nil) {
        self.email = email
        self.password = password
        self.authenticationState = authenticationState
        self.user = user
    }
    
    // MARK: - Methods
    
    func signUpWithEmailAndPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid)")
            authenticationState = .authenticated
            return true
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signInWithEmailAndPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid)")
            authenticationState = .authenticated
            return true
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func updateUserName(name: String) async -> Bool {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        do {
            try await changeRequest?.commitChanges()
            return true
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return false
        }
    }
    
}
