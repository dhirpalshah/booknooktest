//
//  WishBooksManager.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/8/24.
//

import Foundation

class WishBooksManager: ObservableObject {
    @Published var wishBooks: [Book] = []

    func addBook(_ book: Book, readBooksManager: ReadBooksManager) {
        // Ensure the book isn't in the "Read" list
        if !wishBooks.contains(where: { $0.id == book.id }) &&
            !readBooksManager.readBooks.contains(where: { $0.id == book.id }) {
            wishBooks.append(book)
            saveBooks()
        }
    }

    func removeBook(_ book: Book) {
        wishBooks.removeAll { $0.id == book.id }
        saveBooks()
    }

    private func saveBooks() {
        if let encoded = try? JSONEncoder().encode(wishBooks) {
            UserDefaults.standard.set(encoded, forKey: "wishBooks")
        }
    }

    private func loadBooks() {
        if let savedData = UserDefaults.standard.data(forKey: "wishBooks"),
           let decodedBooks = try? JSONDecoder().decode([Book].self, from: savedData) {
            wishBooks = decodedBooks
        }
    }

    init() {
        loadBooks()
    }
}
