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
        provider.request(.exchangeToken(clientId: clientId, clientSecret: clientSecret, code: code, redirectUri: redirectUri)) { result in
            switch result {
            case .success(let response):
                print("DEBUG: \(response)")
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
    
    // Helper function to print the final URL for debugging
        private func printFinalURL(endpoint: Endpoint) {
            #if DEBUG
            print("Final URL: \(endpoint.url)")
            #endif
        }
}
