//
//  NetworkManager.swift
//  GitInsider
//
//  Created by Alphan Ogün on 17.11.2023.
//

import Foundation
import Moya

class NetworkManager {
    private let provider: MoyaProvider<MultiTarget>
    private let decoder: JSONDecoder
    
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider(), decoder: JSONDecoder = JSONDecoder()) {
        self.provider = provider
        self.decoder = decoder
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T: Codable>(_ target: MultiTarget) async throws -> T {
        return try await withCheckedThrowingContinuation({ continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response)
                }
            }
        })
    }
}
