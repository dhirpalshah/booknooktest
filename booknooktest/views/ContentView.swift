//
//  ContentView.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
        }
    }
}

#Preview {
    ContentView()
}

