//
//  AuthCoordinatorTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 1.12.2023.
//

import XCTest
@testable import GitInsider

final class AuthCoordinatorTests: XCTestCase {

    func test_goToSplash() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(navigationController: navigationController)
        
        //WHEN
        sut.start()
        
        //THEN
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is SplashController)
    }
    
    func test_goToLoginPage() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(navigationController: navigationController)
        
        //WHEN
        sut.goToLoginPage()
        
        //THEN
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is LoginController)
    }
    
    func test_goToLoginOnSafari() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(navigationController: navigationController)
        
        //WHEN
        sut.goToLoginOnSafari()
        
        //THEN
        XCTAssertTrue(sut.isViewPresented)
    }
    
    func test_goToSignUpOnSafari() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(navigationController: navigationController)
        
        //WHEN
        sut.goToSignUpOnSafari()
        
        //THEN
        XCTAssertTrue(sut.isViewPresented)
    }
    
    func test_didFinishAuthWithUser() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(navigationController: navigationController)
        let parentCoordinator = AppCoordinator(navigationController: navigationController)
        sut.parentCoordinator = parentCoordinator
        
        //WHEN
        sut.didFinishAuth(withUser: mockUser1)
        
        //THEN
        XCTAssertTrue(navigationController.presentedViewController == nil)
        XCTAssertTrue(navigationController.topViewController is HomeController)
    }
}
