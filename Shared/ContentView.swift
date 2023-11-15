//
//  ContentView.swift
//  Shared
//
//  Created by alvin on 2023-11-15.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @State private var username: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                WelcomeView(username: username)
            } else {
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Login with Username") {
                        isLoggedIn = true
                    }
                    .padding()
                    .disabled(username.isEmpty)

                    Button("Login Anonymously") {
                        username = "Anonymous"
                        isLoggedIn = true
                    }
                    .padding()
                }
                .navigationTitle("Login")
            }
        }
    }
}
