//
//  WishView.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/8/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct WishView: View {
    @EnvironmentObject var readBooksManager: ReadBooksManager
    @EnvironmentObject var wishBooksManager: WishBooksManager

    var body: some View {
        VStack {
            Text("Books You Want to Read")
                .font(.largeTitle)
                .padding()
            
            List(wishBooksManager.wishBooks) { book in
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
                    HStack(spacing: 16) {
                        Button(action: {
                            readBooksManager.addBook(book)
                            wishBooksManager.removeBook(book)
                        }) {
                            Image(systemName: "star")
                                .foregroundColor(.orange)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            wishBooksManager.removeBook(book)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}
