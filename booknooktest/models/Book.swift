//
//  Book.swift
//  booknooktest
//
//  Created by Dhirpal Shah on 11/7/24.
//

import Foundation

struct Book: Identifiable, Codable {
    var id: String
    var title: String
    var authors: String
    var desc: String
    var imurl: String
    var url: String
}

