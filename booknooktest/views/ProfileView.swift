//
//  ProfileView.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/8/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var readBooksManager: ReadBooksManager
    @EnvironmentObject var wishBooksManager: WishBooksManager
    @State private var userName: String = "Dhirpal" // Replace with a user setting if needed

    var body: some View {
        VStack(spacing: 20) {
            Text("happy reading,")
                .font(.title)
                .padding(.top, 20)
            
            Text(userName)
                .font(.largeTitle)
                .padding(.top, 10)
            
            HStack {
                VStack {
                    Text("Books Read")
                        .font(.headline)
                    Text("\(readBooksManager.readBooks.count)")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .padding()

                VStack {
                    Text("Wish List")
                        .font(.headline)
                    Text("\(wishBooksManager.wishBooks.count)")
                        .font(.title)
                        .foregroundColor(.orange)
                }
                .padding()
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
}
