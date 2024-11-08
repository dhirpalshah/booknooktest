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
                    Button(action: {
                        readBooksManager.addBook(book) // Add book without affecting search results
                    }) {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
