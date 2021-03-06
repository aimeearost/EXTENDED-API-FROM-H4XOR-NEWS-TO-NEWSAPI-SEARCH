//
//  PostData.swift
//  H4xor News
//
//  Created by Aimee Arost on 12/23/20.
//

import Foundation

struct Results: Decodable {
    let articles: [Post]
}

//We need the Identifiable protocol to use the Struct inside list and to know how to order each item
struct Post: Decodable, Identifiable {
//    Identifiable protocol requires id, but objectID is the same so this is how to get around it
    var id: String {
//        return author
        return title
    }
    let description: String?
//    let description: String
    let author: String?
    let title: String
    let url: String?
    let source: Source
}

struct Source: Decodable {
    let name: String?
}
//The NetworkManager will then decode this information.

 struct URLName {
    let partialURL = "https://newsapi.org/v2/everything?q="
    var searchTerm: String = "news"
    let apiKey = "&apiKey=8e28babb2a8e4a4a91a9890b14ee915a"
}
