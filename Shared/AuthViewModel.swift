//
//  AuthViewModel.swift
//  ShopMinder
//
//  Created by alvin on 2023-11-22.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var errorMessage: String?

    init() {
        checkCurrentUser()
    }

    func createAccount(email: String, password: String) {
        FirebaseManager.shared.createAccount(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.currentUser = user
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func loginUser(email: String, password: String) {
        FirebaseManager.shared.loginUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.currentUser = user
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func loginAnonymously() {
        print("Attempting anonymous login")
        FirebaseManager.shared.loginAnonymously { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Anonymous login successful")
                    self?.currentUser = user
                    self?.errorMessage = nil
                case .failure(let error):
                    print("Anonymous login failed: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }


    func checkCurrentUser() {
        currentUser = Auth.auth().currentUser
    }

    func logout() {
            do {
                try Auth.auth().signOut()
                DispatchQueue.main.async {
                    self.currentUser = nil
                }
print("log out successful!")
            } catch let signOutError as NSError {
                print("!!!!Error signing out: %@", signOutError)
            }
        }
}
