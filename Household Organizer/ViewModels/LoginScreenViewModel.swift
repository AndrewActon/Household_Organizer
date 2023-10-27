//
//  LoginScreenViewModel.swift
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

@MainActor class LoginScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var authenticationState: AuthenticationState = .authenticated
    @Published var user: UserModel = UserModel(id: "", name: "a", email: "")
    private var firebaseUser: User?
    
    // MARK: - Methods
    func signUpWithEmailAndPassword(email: String, password: String) async -> Bool {
            authenticationState = .authenticating
            do {
                //Network Call
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                firebaseUser = authResult.user
                print("User \(authResult.user.uid)")
                
                //Update User
                user.id = firebaseUser?.uid ?? ""
                user.name = firebaseUser?.displayName ?? ""
                user.email = firebaseUser?.email ?? ""
                
                createNewUser(id: user.id, name: user.name ?? "", email: user.email)
                
                //Update Authentication
                authenticationState = .authenticated
                
                return true
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                authenticationState = .unauthenticated
                return false
            }
        }
    
    func signInWithEmailAndPassword(email: String, password: String) async -> Bool {
            authenticationState = .authenticating
            do {
                //Network Call
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                firebaseUser = authResult.user
                print("User \(authResult.user.uid)")
                
                //Update User
                user.id = firebaseUser?.uid ?? ""
                user.name = firebaseUser?.displayName ?? ""
                user.email = firebaseUser?.email ?? ""
                
                //Update Authentication
                authenticationState = .authenticated
                
                return true
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                authenticationState = .unauthenticated
                return false
            }
        }
    
    func createNewUser(id: String, name: String, email: String) {
        AppDelegate.db.collection("Users").document(user.email).setData([
            "id" : user.id,
            "name" : user.name ?? "",
            "email" : user.email
        ]) { error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            } else {
                print("Document added")
            }
        }
    }
}
