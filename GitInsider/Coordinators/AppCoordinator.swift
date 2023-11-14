//
//  AppCoordinator.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit
import SafariServices
import KeychainSwift

protocol Coordinator: AnyObject {
    var child: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var child: [Coordinator] = []
    var navigationController: UINavigationController
    let keychain = KeychainSwift()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSplash()
    }
    
    func goToHome(withUser user: User) {
        let homeController = HomeController()
        let homeViewModel = HomeViewModel(user: user)
        homeViewModel.coordinator = self
        homeController.viewModel = homeViewModel
        navigationController.pushViewController(homeController, animated: true)
    }
    
    func goToSplash() {
        let splashController = SplashController()
        let splashViewModel = SplashViewModel()
        splashViewModel.coordinator = self
        splashController.viewModel = splashViewModel
        navigationController.pushViewController(splashController, animated: false)
    }
    
    func goToLoginPage() {
        let loginController = LoginController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginController.viewModel = loginViewModel
        navigationController.pushViewController(loginController, animated: false)
    }
    
    func goToLoginOnSafari() {
        guard let url = URL(string: gitHubAuthLink) else { return }
        //        UIApplication.shared.open(url)
        let safari = SFSafariViewController(url: url)
        //        safari.modalPresentationStyle = .pageSheet
        navigationController.pushViewController(safari, animated: true)
    }
    
    func goToSignUpOnSafari() {
        guard let url = URL(string: gitHubSignupLink) else { return }
        UIApplication.shared.open(url)
    }
}
