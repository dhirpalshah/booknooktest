//
//  ContentView.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var readBooksManager = ReadBooksManager()
    @StateObject private var wishBooksManager = WishBooksManager()
    @StateObject private var books = BookDataFetcher()

    var body: some View {
        TabView {
            ReadView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Read")
                }
            HomeView(books: books)
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
            WishView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Wish List")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .environmentObject(readBooksManager)
        .environmentObject(wishBooksManager)
    }
}

#Preview {
    ContentView()
}

