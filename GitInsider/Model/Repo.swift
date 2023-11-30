//
//  Repo.swift
//  GitInsider
//
//  Created by Alphan Ogün on 17.11.2023.
//

import Foundation

// MARK: - Repo

struct Repo: Codable {
    let id: Int
    let name, fullName: String
    let htmlUrl: String
    let description: String?
}

