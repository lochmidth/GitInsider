//
//  MockOAuthManager.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 29.11.2023.
//

import Foundation
@testable import GitInsider

class MockOAuthManager: OAuthManaging {
    
    var result: Result<String, Error>?
    var ishandleCallBackCalled = false
    
    func handleCallBack(fromUrl url: URL) async throws -> String {
        ishandleCallBackCalled = true
        
        if let result = result {
            switch result {
            case .success(let code):
                return code
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.invalidURI
        }
    }
}
