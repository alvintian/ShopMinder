//
//  AnonymousLoginView.swift
//  ShopMinder
//
//  Created by alvin on 2023-11-22.
//
import SwiftUI

struct AnonymousLoginView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        Button("Login Anonymously") {
            viewModel.loginAnonymously()
        }
    }
}

