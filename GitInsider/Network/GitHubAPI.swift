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
    case getUser(username: String)
    case searchUser(query: String)
    case checkIfUserFollowing(username: String)
    case follow(username: String)
    case unfollow(username: String)
}

extension GitHubAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .exchangeToken:
            return URL(string: "https://github.com")!
        case .getCurrentUser:
            return URL(string: "https://api.github.com")!
        case .getUser:
            return URL(string: "https://api.github.com")!
        case .searchUser:
            return URL(string: "https://api.github.com")!
        case .checkIfUserFollowing:
            return URL(string: "https://api.github.com")!
        case .follow:
            return URL(string: "https://api.github.com")!
        case . unfollow:
            return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .exchangeToken:
            return "/login/oauth/access_token"
        case .getCurrentUser:
            return "/user"
        case .getUser(let username):
            return "/users/\(username)"
        case .searchUser:
            return "/search/users"
        case .checkIfUserFollowing(let username):
            return "/user/following/\(username)"
        case .follow(let username):
            return "/user/following/\(username)"
        case .unfollow(let username):
            return "/user/following/\(username)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .exchangeToken:
            return .post
        case .getCurrentUser:
            return .get
        case .getUser:
            return .get
        case .searchUser:
            return .get
        case .checkIfUserFollowing:
            return .get
        case .follow:
            return .put
        case .unfollow:
            return .delete
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
                "redirect_uri": gitHubRedirectUri
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getCurrentUser:
            return .requestPlain
        case .getUser:
            return .requestPlain
        case .searchUser(let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.queryString)
        case .checkIfUserFollowing:
            return .requestPlain
        case .follow:
            return .requestPlain
        case .unfollow:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .exchangeToken:
            return ["Accept": "application/json"]
        case .getCurrentUser:
            let keychain = KeychainSwift()
            let accessToken = keychain.get("Access Token")
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken ?? "")",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        case .getUser:
            let keychain = KeychainSwift()
            let accessToken = keychain.get("Access Token")
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken ?? "")",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        case .searchUser:
            let keychain = KeychainSwift()
            let accessToken = keychain.get("Access Token")
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken ?? "")",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        case .checkIfUserFollowing:
            let keychain = KeychainSwift()
            let accessToken = keychain.get("Access Token")
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken ?? "")",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        case .follow:
            let keychain = KeychainSwift()
            let accessToken = keychain.get("Access Token")
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken ?? "")",
                "Content-Length": "0",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        case .unfollow:
            let keychain = KeychainSwift()
            let accessToken = keychain.get("Access Token")
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken ?? "")",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        }
    }
    
//    var validationType: ValidationType {
//            return .successAndRedirectCodes
//        }
}
