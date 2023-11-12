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
    
    func exchangeToken(code: String) async throws -> String {
        
        let request1 = GitHubAPI.exchangeToken(code: code)
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(request1) { result in
                switch result {
                case .success(let response):
                    do {
                        let accessTokenResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: response.data)
                        let accessToken = accessTokenResponse.accessToken
                        continuation.resume(with: .success(accessToken))
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}
