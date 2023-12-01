//
//  mockNetworkManager.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 28.11.2023.
//

import Foundation
import Moya
@testable import GitInsider

public enum MockError: Error {
    case someError
    case invalidURI
    case invalidCode
    case invalidAccessToken
    case invalidUsername
}

class MockNetworkManager: NetworkManaging {
    
    var result: Result<Any, Error>?
    
    var isRequestCalled = false
    func request<T: Codable>(_ target: Moya.TargetType) async throws -> T {
        isRequestCalled = true
        
        if let result = result {
            switch result {
            case .success(let value as T):
                return value
            case .failure(let error):
                throw error
            default:
                throw MockError.someError
            }
        } else {
            throw MockError.someError
        }
    }
    var isrequestIsStatusValidCalled = false
    func requestIsStatusValid(_ target: Moya.TargetType) async throws -> Bool {
        isrequestIsStatusValidCalled = true
        
        if let result = result {
            switch result {
            case .success:
                return true
            case .failure:
                return false
            }
        } else {
            throw MockError.someError
        }
    }
}
