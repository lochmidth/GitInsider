//
//  AccessTokenResponse.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation

// MARK: - AccessTokenResponse
struct AccessTokenResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int
    let tokenType, scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
        case tokenType = "token_type"
        case scope
    }
}
