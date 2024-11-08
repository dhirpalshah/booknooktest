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
        }
        .environmentObject(readBooksManager)
    }
}

#Preview {
    ContentView()
}

