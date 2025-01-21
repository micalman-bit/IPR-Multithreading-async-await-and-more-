//
//  Todo.swift
//  Todo
//
//  Created by Andrey Samchenko
//

import Foundation

struct Todo: Decodable {
    let id: Int 
    let title: String
    let completed: Bool
}
