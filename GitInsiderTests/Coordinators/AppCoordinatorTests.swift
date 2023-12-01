//
//  AppCoordinatorTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 1.12.2023.
//

import XCTest
@testable import GitInsider

final class AppCoordinatorTests: XCTestCase {
    
    func test_goToHomeWithUser() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AppCoordinator(navigationController: navigationController)
        
        //WHEN
        sut.goToHome(withUser: mockUser1)
        
        //THEN
        XCTAssertTrue(sut.childCoordinators.count == 1)
        XCTAssertTrue(sut.childCoordinators.first is HomeCoordinator)
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is HomeController)
    }
    
    func test_goToAuth() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AppCoordinator(navigationController: navigationController)
        
        //WHEN
        sut.goToAuth()
        
        //THEN
        XCTAssertTrue(sut.childCoordinators.count == 1)
        XCTAssertTrue(sut.childCoordinators.first is AuthCoordinator)
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is SplashController)
    }

    func test_childDidFinish() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AppCoordinator(navigationController: navigationController)
        let child = AuthCoordinator(navigationController: navigationController)
        sut.childCoordinators.append(child)
        
        //WHEN
        sut.childDidFinish(child)
        
        //THEN
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
}
