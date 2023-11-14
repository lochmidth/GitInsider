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
    
    deinit {
        print("DEBUG: Deallocating \(self)")
    }
    
    func start() {
        if let accessToken = keychain.get("Access Token"), accessToken.isEmpty {
            print("DEBUG: Access token in keychain is \(accessToken)")
            goToContainer()
        } else {
            goToLoginPage()
        }
    }
    
    func goToContainer() {
<<<<<<< Updated upstream
        let containerController = ContainerController()
        navigationController.pushViewController(containerController, animated: true)
=======
        let containerViewModel = ContainerViewModel()
        containerViewModel.coordinator = self
        let containerController = ContainerController(viewModel: containerViewModel)
        containerController.modalPresentationStyle = .fullScreen
        navigationController.show(containerController, sender: self)
>>>>>>> Stashed changes
    }
    
    func goToLoginPage() {
        let loginController = LoginController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginController.viewModel = loginViewModel
        navigationController.show(loginController, sender: self)
    }
    
    func goToLoginOnSafari() {
<<<<<<< Updated upstream
        guard let url = URL(string: "https://github.com/login/oauth/authorize?client_id=38fecaa5dc828643d268") else { return }
        UIApplication.shared.open(url)
=======
        guard let url = URL(string: gitHubAuthLink) else { return }
//        UIApplication.shared.open(url)
        let safari = SFSafariViewController(url: url)
//        safari.modalPresentationStyle = .pageSheet
        navigationController.show(safari, sender: self)
>>>>>>> Stashed changes
    }
    
    func goToSignUpOnSafari() {
        guard let url = URL(string: "https://github.com/signup") else { return }
        UIApplication.shared.open(url)
    }
}
