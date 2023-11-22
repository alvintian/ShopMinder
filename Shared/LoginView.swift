//
//  LoginView.swift
//  ShopMinder
//
//  Created by alvin on 2023-11-22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isNewUser = false

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if isNewUser {
                Button("Create Account") {
                    viewModel.createAccount(email: email, password: password)
                }
            } else {
                Button("Login") {
                    viewModel.loginUser(email: email, password: password)
                }
            }

            Button("Switch to \(isNewUser ? "Login" : "Create Account")") {
                isNewUser.toggle()
            }
        }
        .padding()
    }
}
