//
//  WelcomeView.swift
//  ShopMinder
//
//  Created by alvin on 2023-11-15.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var username: String

    var body: some View {
        Text("Welcome, \(username)!")
            .font(.largeTitle)
            .padding()
    }
}
