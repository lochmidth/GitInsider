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
    var navigationController : UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let keychain = KeychainSwift()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToAuth()
    }
    
    func goToHome(withUser user: User) {
        if let existingHomeController = childCoordinators.first(where: { $0 is HomeCoordinator }) as? HomeCoordinator {
            existingHomeController.user = user
        } else {
            let child = HomeCoordinator(navigationController: navigationController, user: user)
            child.parentCoordinator = self
            childCoordinators.append(child)
            child.start()
        }
    }
    
    func goToAuth() {
        let child = AuthCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
