//
//  Users.swift
//  GitInsider
//
//  Created by Alphan Ogün on 16.11.2023.
//

import Foundation

// MARK: - Users
struct Users: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let login: String
    let avatarUrl: String
}
