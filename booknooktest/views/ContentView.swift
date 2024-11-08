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
        NavigationView {
            HomeView()
                .navigationTitle("Books")
        }
    }
}

#Preview {
    ContentView()
}

