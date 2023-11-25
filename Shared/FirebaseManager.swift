//
//  FirebaseManager.swift
//  ShopMinder
//
//  Created by alvin on 2023-11-21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()

    func createAccount(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }

    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }

    func loginAnonymously(completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
    func fetchShoppingList(forUser user: User, completion: @escaping ([String]) -> Void) {
            db.collection("shoppingLists").document(user.uid).getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    let items = data?["items"] as? [String] ?? []
                    completion(items)
                } else {
                    print("Document does not exist")
                    completion([])
                }
            }
        }

        // Method to update the shopping list
        func updateShoppingList(forUser user: User, items: [String]) {
            db.collection("shoppingLists").document(user.uid).setData(["items": items]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
}
