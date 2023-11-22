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

    func createAccount(email: String, password: String) {
        FirebaseManager.shared.createAccount(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.currentUser = user
                case .failure(let error):
                    print("Error creating account: \(error.localizedDescription)")
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
                case .failure(let error):
                    print("Error logging in: \(error.localizedDescription)")
                }
            }
        }
    }

    func loginAnonymously() {
        FirebaseManager.shared.loginAnonymously { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.currentUser = user
                case .failure(let error):
                    print("Error logging in anonymously: \(error.localizedDescription)")
                }
            }
        }
    }
}
