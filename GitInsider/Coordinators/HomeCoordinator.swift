//
//  HomeCoordinator.swift
//  GitInsider
//
//  Created by Alphan Ogün on 27.11.2023.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var user: User
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
       goToHome()
    }
    
    func goToHome() {
        let homeController = HomeController()
        let homeViewModel = HomeViewModel(user: user)
        homeViewModel.coordinator = self
        homeController.viewModel = homeViewModel
        navigationController.pushViewController(homeController, animated: true)
    }
    
    func goToProfile(withUser user: User) {
        let profileController = ProfileController()
        let profileViewModel = ProfileViewModel(user: user)
        profileViewModel.coordinator = self
        profileController.viewModel = profileViewModel
        navigationController.pushViewController(profileController, animated: true)
    }
    
    func goToSafari(withUrl url: URL) {
        let webController = WebController(url: url)
        let webViewModel = WebViewModel()
//        webViewModel.coordinator = self
        webController.viewModel = webViewModel
        navigationController.pushViewController(webController, animated: true)
    }
    
    func signOut() {
        navigationController.popToRootViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
    
}
