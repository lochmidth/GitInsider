//
//  HomeCoordinatorTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 1.12.2023.
//

import XCTest
@testable import GitInsider

final class HomeCoordinatorTests: XCTestCase {

    func test_goToHome() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = HomeCoordinator(navigationController: navigationController, user: mockUser1)
        
        //WHEN
        sut.goToHome()
        
        //THEN
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is HomeController)
    }
    
    func test_goToProfileWithUser() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = HomeCoordinator(navigationController: navigationController, user: mockUser1)
        
        //WHEN
        sut.goToProfile(withUser: mockUser1)
        
        //THEN
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is ProfileController)
    }
    
    func test_goToSafariWithUrl() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = HomeCoordinator(navigationController: navigationController, user: mockUser1)
        
        //WHEN
        sut.goToSafari(withUrl: URL(string: "www.google.com")!)
        
        //THEN
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.topViewController is WebController)
    }
    
    func test_signOut() {
        //GIVEN
        let navigationController = UINavigationController()
        let sut = HomeCoordinator(navigationController: navigationController, user: mockUser1)
        let parentCoordinator = AppCoordinator(navigationController: navigationController)
        sut.parentCoordinator = parentCoordinator
        
        //WHEN
        sut.signOut()
        
        //THEN
        
        XCTAssertEqual(navigationController.viewControllers.count, 0)
    }
}
