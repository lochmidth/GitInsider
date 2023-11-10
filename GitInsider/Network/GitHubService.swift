//
//  GitHubService.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation
import Moya

class GitHubService {
    let provider = MoyaProvider<GitHubAPI>()
    
    func exchangeToken(clientId: String, clientSecret: String, code: String, redirectUri: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let request = GitHubAPI.exchangeToken(clientId: clientId, clientSecret: clientSecret, code: code, redirectUri: redirectUri)
        provider.request(request) { result in
            switch result {
            case .success(let response):
                do {
                    let accessTokenResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: response.data)
                    let accessToken = accessTokenResponse.accessToken
                    completion(.success(accessToken))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
