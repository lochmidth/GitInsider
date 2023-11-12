//
//  OAuthManager.swift
//  GitInsider
//
//  Created by Alphan Ogün on 10.11.2023.
//

import Foundation

enum OAuthError: Error {
    case invalidScheme
    case invalidHost
    case invalidQueryItem
    case invalidCode
}

class OAuthManager {
    
    
    func handleCallBack(withUrl url: URL) async throws -> String {
        guard url.scheme == "gitinsider" else { throw OAuthError.invalidScheme }
        guard url.host() == "github" && url.path() == "/callback" else { throw OAuthError.invalidHost}
        guard let query = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw OAuthError.invalidQueryItem}
        guard let code = query.queryItems?.first(where: { $0.name == "code" })?.value else { throw OAuthError.invalidCode}
        return code
    }
}
