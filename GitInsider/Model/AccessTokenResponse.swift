//
//  AccessTokenResponse.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation

struct AccessTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
}
