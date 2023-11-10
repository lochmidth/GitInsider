//
//  AccessTokenResponse.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation

// MARK: - AccessTokenResponse
struct AccessTokenResponse: Codable {
    let accessToken, tokenType, scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
    }
}
