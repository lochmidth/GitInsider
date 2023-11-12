//
//  GitHubAPI.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation
import Moya
import KeychainSwift

enum GitHubAPI {
    case exchangeToken(code: String)
    case getCurrentUser
}

extension GitHubAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .exchangeToken:
            return URL(string: "https://github.com")!
        case .getCurrentUser:
            return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .exchangeToken:
            return "/login/oauth/access_token"
        case .getCurrentUser:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .exchangeToken:
            return .post
        case .getCurrentUser:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .exchangeToken(let code):
            let parameters: [String: Any] = [
                "client_id": gitHubClientId,
                "client_secret": gitHubClientSecret,
                "code": code,
                "redirect_uri": gitHubredirectUri
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getCurrentUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .exchangeToken:
            return ["Accept": "application/json"]
        case .getCurrentUser:
            guard let accessToken = KeychainSwift().get("Access Token") else { return ["":""]}
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken)",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        }
    }
}
