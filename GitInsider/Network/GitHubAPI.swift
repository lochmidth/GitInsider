//
//  GitHubAPI.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation
import Moya

enum GitHubAPI {
    case exchangeToken(clientId: String, clientSecret: String, code: String, redirectUri: String)
}

extension GitHubAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .exchangeToken(_, _, _, let redirectUri):
            return URL(string: "https://github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .exchangeToken:
            return "/login/oauth/access_token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .exchangeToken:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .exchangeToken(let clientId, let clientSecret, let code, let redirectUri):
            let parameters: [String: Any] = [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code,
                "redirect_uri": redirectUri
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .exchangeToken:
            return ["Accept": "application/json"]
        }
    }
}
