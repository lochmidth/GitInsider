//
//  AppDelegate.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
      
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Task {
            let code = try await OAuthManager.shared.handleCallBack(withUrl: url)
            print("DEBUG: Callback code is \(code)")
            GitHubService().exchangeToken(clientId: "38fecaa5dc828643d268", clientSecret: "d3920ab39a9da67eebd47c7b0c2f736458b46641", code: code, redirectUri: "gitinsider://github/callback") { result in
                switch result {
                case .success(let accessToken):
                    print("DEBUG: Access token is \(accessToken)")
                case .failure(let error):
                    print("DEBUG: Error while exchanging code with Access Token. \(error.localizedDescription)")
                }
            }
        }
        return false
    }
}

