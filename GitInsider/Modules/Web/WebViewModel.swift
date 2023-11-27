//
//  WebViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 27.11.2023.
//

import Foundation

class WebViewModel {
    //MARK: - Properties
    
    let oAuthManager: OAuthManager
    
    init(oAuthManager: OAuthManager = OAuthManager()) {
        self.oAuthManager = oAuthManager
    }
    
    func handleCallback(fromUrl url: URL) {
        Task {
            let code = try await oAuthManager.handleCallBack(fromUrl: url)
            print("DEBUG: Code in webview is \(code)")
            NotificationCenter.default.post(name: .didReceiveCode, object: nil, userInfo: ["code": code])
        }
    }
}
