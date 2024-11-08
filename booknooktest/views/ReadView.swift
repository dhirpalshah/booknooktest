//
//  ReadView.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/8/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReadView: View {
    @EnvironmentObject var readBooksManager: ReadBooksManager

    var body: some View {
        VStack {
            Text("Books You've Read")
                .font(.largeTitle)
                .padding()
            
            List(readBooksManager.readBooks) { book in
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
                        readBooksManager.removeBook(book)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
