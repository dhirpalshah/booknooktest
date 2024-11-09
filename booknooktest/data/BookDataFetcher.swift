//
//  BookDataFetcher.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation
import SwiftyJSON
import SwiftUI
import Combine

class ReadBooksManager: ObservableObject {
    @Published var readBooks: [Book] = []
    @Published var flashMessage: String = ""
    

    init() {
        loadBooks()
    }

    func addBook(_ book: Book) {
        if !readBooks.contains(where: { $0.id == book.id }) {
            readBooks.append(book)
            saveBooks()
            print("added book")
        }
    }

    func removeBook(_ book: Book) {
        readBooks.removeAll { $0.id == book.id }
        saveBooks()
        print("removed book")
    }

    private func saveBooks() {
        if let encoded = try? JSONEncoder().encode(readBooks) {
            UserDefaults.standard.set(encoded, forKey: "readBooks")
        }
    }

    private func loadBooks() {
        if let savedData = UserDefaults.standard.data(forKey: "readBooks"),
           let decodedBooks = try? JSONDecoder().decode([Book].self, from: savedData) {
            readBooks = decodedBooks
        }
    }
}

class BookDataFetcher: ObservableObject {
    @Published var data = [Book]()

    func fetchData(query: String) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        print("searching:")
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            let json = try! JSON(data: data)
            
            
            
            let items = json["items"].arrayValue
            
            DispatchQueue.main.async {
                var newBooks: [Book] = []

                for item in items {
                    let title = item["volumeInfo"]["title"].stringValue
                    print(title)
                    let authors = item["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }.joined(separator: ", ")
                    let description = item["volumeInfo"]["description"].stringValue
                    let imageURL = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                    let bookURL = item["volumeInfo"]["previewLink"].stringValue
                        
                    newBooks.append(Book(id: title, title: title, authors: authors, desc: description, imurl: imageURL, url: bookURL))
                }
                    
                self.data = newBooks
            }
        }.resume()
    }
    
}
