//
//  AppCoordinator.swift
//  GitInsider
//
//  Created by Alphan Ogün on 8.11.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
    
    func goToContainer() {
        let containerController = ContainerController()
        containerController.modalPresentationStyle = .fullScreen
        navigationController.present(containerController, animated: true)
    }
    
    func goToLoginPage() {
        let loginController = LoginController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginController.viewModel = loginViewModel
        
        navigationController.pushViewController(loginController, animated: true)
    }
    
    func goToLoginOnSafari() {
        guard let url = URL(string: gitHubAuthLink) else { return }
        UIApplication.shared.open(url)
    }
    
    func goToSignUpOnSafari() {
        guard let url = URL(string: githubSignUpLink) else { return }
        UIApplication.shared.open(url)
    }
}
