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

                List(shoppingItems, id: \.self) { item in
                    Text(item)
                }

                Button("Logout") {
                    authViewModel.logout()
                }
                .padding()
                .background(Color.red)
  //              .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()
            }
            .navigationBarTitle("Shopping List", displayMode: .inline)
        }
    }

    private func addItem() {
        let trimmedItem = newItem.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedItem.isEmpty {
            shoppingItems.append(trimmedItem)
            newItem = ""
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView().environmentObject(AuthViewModel())
    }
}
