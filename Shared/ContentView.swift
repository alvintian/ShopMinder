//
//  ContentView.swift
//  Shared
//
//  Created by alvin on 2023-11-15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showLoginOptions = true
    @State private var showFirebaseLogin = false
    @State private var viewID = UUID()

    var body: some View {
        NavigationView {
            VStack {
                if authViewModel.currentUser != nil {
                    ShoppingListView()
                } else if showLoginOptions {
                    initialView
                } else if showFirebaseLogin {
                    LoginView(viewModel: authViewModel, onBack: {
                        // This closure defines what happens when "Back" is tapped in LoginView
                        showLoginOptions = true
                        showFirebaseLogin = false
                    })
                }
            }
        }
        .id(viewID)
        .onAppear {
            authViewModel.checkCurrentUser()
        }
        .onReceive(authViewModel.$currentUser) { user in
            if user == nil {
                showLoginOptions = true
                showFirebaseLogin = false
                viewID = UUID()  // Update the ID to force view refresh
            }
        }}

    var initialView: some View {
        VStack {
            Text("Welcome to Shopminder")
                .font(.largeTitle)
                .padding()

            Button("Login with Firebase") {
                showFirebaseLogin = true
                showLoginOptions = false
            }
            .padding()

            Button("Login Anonymously") {
                authViewModel.loginAnonymously()
            }
            .padding()
        }
    }
}
