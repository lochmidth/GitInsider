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
//        let navigationController = UINavigationController()
//        appCoordinator = AppCoordinator(navigationController: navigationController)
//        appCoordinator!.start()
        window!.rootViewController = ContainerController()
        window!.makeKeyAndVisible()
        return true
    }
}

