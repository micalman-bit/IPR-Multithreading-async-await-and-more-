//
//  NewsSource.swift
//  NewsApp
//
//  Created by Andrey Samchenko
//

import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}
