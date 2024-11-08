//
//  BookDataFetcher.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation
import SwiftyJSON

class BookDataFetcher: ObservableObject {
    @Published var data = [Book]()

    func fetchData(query: String) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
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
                self.data = items.map { item in
                    let title = item["volumeInfo"]["title"].stringValue
                    let authors = item["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }.joined(separator: ", ")
                    let description = item["volumeInfo"]["description"].stringValue
                    let imageURL = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                    let bookURL = item["volumeInfo"]["previewLink"].stringValue
                    
                    return Book(id: title, title: title, authors: authors, desc: description, imurl: imageURL, url: bookURL)
                }
            }
        }.resume()
    }
}
