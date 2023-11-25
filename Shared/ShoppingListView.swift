//
//  ShoppingListView.swift
//  ShopMinder
//
//  Created by alvin on 2023-11-22.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var newItem: String = ""
    @State private var shoppingItems: [String] = []
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Shopminder")
                    .font(.largeTitle)
                    .padding()

                HStack {
                    TextField("Add new item", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: addItem) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Circle().fill(Color.blue))
                            .foregroundColor(.white)
                    }
                }

                List {
                    ForEach(shoppingItems, id: \.self) { item in
                        HStack {
                            Text(item)
                            Spacer()
                            Button(action: { self.deleteItem(item: item) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }

                Button("Logout") {
                    authViewModel.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()
            }
            .navigationBarTitle("Shopping List", displayMode: .inline)
            .onAppear {
                loadShoppingList()
            }
        }
    }

    private func addItem() {
        let trimmedItem = newItem.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedItem.isEmpty {
            shoppingItems.append(trimmedItem)
            newItem = ""
            saveShoppingList()
        }
    }

    private func deleteItem(item: String) {
        if let index = shoppingItems.firstIndex(of: item) {
            shoppingItems.remove(at: index)
            saveShoppingList()
        }
    }

    private func loadShoppingList() {
        guard let user = authViewModel.currentUser else { return }
        FirebaseManager.shared.fetchShoppingList(forUser: user) { items in
            self.shoppingItems = items
        }
    }

    private func saveShoppingList() {
        guard let user = authViewModel.currentUser else { return }
        FirebaseManager.shared.updateShoppingList(forUser: user, items: shoppingItems)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView().environmentObject(AuthViewModel())
    }
}
