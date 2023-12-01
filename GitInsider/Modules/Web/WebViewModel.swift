//
//  WebViewModel.swift
//  GitInsider
//
//  Created by Alphan Ogün on 27.11.2023.
//

import Foundation

protocol WebViewModelDelegate: AnyObject {
    func didReceiveCode(_ code: String)
}

class WebViewModel {
    //MARK: - Properties
    
    let oAuthManager: OAuthManaging
    let notificationCenter: NotificationCenter
//    var coordinator: Coordinator?
    
    init(oAuthManager: OAuthManaging = OAuthManager(), notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.oAuthManager = oAuthManager
        self.notificationCenter = notificationCenter
    }
    
    func handleCallback(fromUrl url: URL) {
        Task {
            let code = try await oAuthManager.handleCallBack(fromUrl: url)
            print("DEBUG: Code in webview is \(code)")
            notificationCenter.post(name: .didReceiveCode, object: nil, userInfo: ["code": code])
        }
    }
}
