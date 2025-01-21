//
//  RandomImage.swift
//  RandomImage
//
//  Created by Andrey Samchenko
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let content: String
}
