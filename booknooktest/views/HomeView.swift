//
//  HomeView.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @ObservedObject var books: BookDataFetcher // Use @ObservedObject for BookDataFetcher
    @EnvironmentObject var readBooksManager: ReadBooksManager // Use EnvironmentObject for ReadBooksManager
    @EnvironmentObject var wishBooksManager: WishBooksManager
    @State private var searchQuery = ""
    

    var body: some View {
        VStack {
            Text("Search Books")
                .font(.largeTitle)
                .padding()
            TextField("Search for a book...", text: $searchQuery, onCommit: {
                books.fetchData(query: searchQuery)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            List(books.data) { book in
                HStack {
                    if let imageURL = URL(string: book.imurl) {
                        WebImage(url: imageURL)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 75)
                            .cornerRadius(5)
                    } else {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 75)
                            .cornerRadius(5)
                    }
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.authors)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    // Wrap buttons in individual HStacks with padding and spacing
                    HStack(spacing: 16) {
                        Button(action: {
                            toggleReadStatus(for: book)
                        }) {
                            Image(systemName: isBookRead(book) ? "checkmark.circle.fill" : "bookmark.fill")
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle()) // Prevents button styling from interfering
                        
                        Button(action: {
                            toggleWishStatus(for: book)
                        }) {
                            Image(systemName: isBookWished(book) ? "star.circle.fill" : "star")
                                .foregroundColor(.orange)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical, 8)
                    
                }
            }
        }
    }
    private func isBookRead(_ book: Book) -> Bool {
        return readBooksManager.readBooks.contains(where: { $0.id == book.id })
    }
    
    private func isBookWished(_ book: Book) -> Bool {
        return wishBooksManager.wishBooks.contains(where: { $0.id == book.id })
    }
    
    private func toggleReadStatus(for book: Book) {
        if isBookRead(book) {
            readBooksManager.removeBook(book)
        } else {
            readBooksManager.addBook(book)
        }
    }
    
    private func toggleWishStatus(for book: Book) {
        if isBookWished(book) {
            wishBooksManager.removeBook(book)
        } else {
            readBooksManager.removeBook(book) // Ensure exclusivity
            wishBooksManager.addBook(book, readBooksManager: readBooksManager)
        }
    }
}
