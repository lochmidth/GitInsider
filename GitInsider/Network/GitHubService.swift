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
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func exchangeToken(code: String) async throws -> AccessTokenResponse {
        let request = GitHubAPI.exchangeToken(code: code)
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(request) { result in
                switch result {
                case .success(let response):
                    do {
                        let accessTokenResponse = try self.decoder.decode(AccessTokenResponse.self, from: response.data)
                        continuation.resume(with: .success(accessTokenResponse))
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func getCurrentUser(completion: @escaping(Result<User, Error>) -> Void) {
        let request = GitHubAPI.getCurrentUser
        provider.request(request) { result in
            switch result {
            case .success(let response):
                do {
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let user = try self.decoder.decode(User.self, from: response.data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
