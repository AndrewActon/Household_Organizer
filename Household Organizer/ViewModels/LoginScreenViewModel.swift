//
//  LoginScreenViewModel.swift
//  Household Organizer
//
//  Created by Andrew Acton on 10/19/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

@MainActor class LoginScreenViewModel: ObservableObject {
    // MARK: - Properties
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var firebaseUser: User?
    @Published var selectedHousehold: Household?
    
    var email: String = ""
    var password: String = ""
    var displayName: String = ""
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    
    // MARK: - Initializer
    init() {
        registerAuthStatHandler()
    }
    
    // MARK: - Methods
    func registerAuthStatHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.firebaseUser = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
               
                guard let id = self.firebaseUser?.uid,
                      let name = self.firebaseUser?.displayName,
                      let email = self.firebaseUser?.email
                else { return }
                
                let appUser = UserModel(id: id, name: name, email: email)
                
                UserManager.shared.user = appUser
            })
        }
    }
    
    func signUpWithEmailAndPassword(email: String, password: String, displayName: String) async -> Bool {
            authenticationState = .authenticating
            do {
                //Network Call
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                firebaseUser = authResult.user
                print("User \(authResult.user.uid)")
                
                //Update User
                UserManager.shared.user.id = firebaseUser?.uid ?? ""
                UserManager.shared.user.name = firebaseUser?.displayName ?? ""
                UserManager.shared.user.email = firebaseUser?.email ?? ""
                
                await createNewUser(id: UserManager.shared.user.id, name: UserManager.shared.user.name ?? "", email: UserManager.shared.user.email)
                await updateUserDisplayName(name: displayName)
                
                
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
                UserManager.shared.user.id = firebaseUser?.uid ?? ""
                UserManager.shared.user.name = firebaseUser?.displayName ?? ""
                UserManager.shared.user.email = firebaseUser?.email ?? ""
                
                //Update Authentication
                authenticationState = .authenticated
                
                return true
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                authenticationState = .unauthenticated
                return false
            }
    }
    
    func createNewUser(id: String, name: String, email: String) async {
        //Create user object
        let newUser = UserModel(id: id, name: name, email: email)
        //Create doc reference
        let docRef = AppDelegate.db.collection("Users").document(id)
        //Set document
        do {
            try docRef.setData(from: newUser)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
        }
    }
    
    func updateUserDisplayName(name: String) async -> Bool {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        do {
            //Update Authentication User
            try await changeRequest?.commitChanges()
            UserManager.shared.user.name = name
            print("Updated name: \(UserManager.shared.user.name ?? "")")
            
            //Update Firestore User
            try await AppDelegate.db.collection("Users").document(UserManager.shared.user.id).updateData(["name" : name])
            
            return true
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            return false
        }
    }
    
    func deleteAccount() {
        firebaseUser?.delete()
        authenticationState = .unauthenticated
    }
    
}
