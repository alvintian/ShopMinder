//
//  ShopMinderApp.swift
//  Shared
//etstsets
//  Created by alvin on 2023-11-15.
//

import SwiftUI

@main
struct ShopMinderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
