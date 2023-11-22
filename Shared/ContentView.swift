//
//  ContentView.swift
//  Shared
//
//  Created by alvin on 2023-11-15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Login with Firebase", destination: LoginView())
                NavigationLink("Login Anonymously", destination: AnonymousLoginView())
            }
        }
    }
}
