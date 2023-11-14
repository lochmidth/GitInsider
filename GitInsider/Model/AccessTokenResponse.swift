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
    let expiresIn: Int // 8-hours, will be used for authenticate navigation (skip login if it is not expired)
    let refreshToken: String
    let refreshTokenExpiresIn: Int
    let tokenType, scope: String
}
