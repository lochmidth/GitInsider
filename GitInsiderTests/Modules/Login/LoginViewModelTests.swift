//
//  LoginViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import XCTest
@testable import GitInsider

final class LoginViewModelTests: XCTestCase {
    
    func test_givenValidNotification_whenHandleReceiveCode_thenSuccessWithAuth() {
        //GIVEN
        let mockService = MockGitHubService()
        mockService.result = .success(mockAccessTokenResponse)
        mockService.resultForCurrentUser = .success(mockUser1)
        let mockKeychain = MockKeychainSwift()
        let mockUserDefaults = MockUserDefaults()
        let mockNotificationCenter = MockNotificationCenter()
        let mockCoordinator = MockAuthCoordinator(navigationController: UINavigationController())
        
        let notification = Notification(
            name: Notification.Name("TestNotification"),
            object: nil,
            userInfo: ["code": "testCode"]
        )
        
        let sut = LoginViewModel(gitHubService: mockService, keychain: mockKeychain, notificationCenter: mockNotificationCenter, userDefaults: mockUserDefaults)
        sut.coordinator = mockCoordinator
        
        let expectation = XCTestExpectation(description: "DidHandleReceiveCode")
        
        //WHEN
        sut.handleReceiveCode(notification)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 3.0)
        
        XCTAssertTrue(mockService.isExchangeTokenCalled)
        XCTAssertEqual(mockKeychain.get(accessTokenInKeychain), "a1b2c3d4e5f6g7h8i9j0")
        XCTAssertTrue(mockUserDefaults.isSetCalled)
    }
    
    func test_givenNothing_whenGoToLogin_thenSuccess() {
        //GIVEN
        let mockService = MockGitHubService()
        let mockKeychain = MockKeychainSwift()
        let mockUserDefaults = MockUserDefaults()
        let mockNotificationCenter = MockNotificationCenter()
        let mockCoordinator = MockAuthCoordinator(navigationController: UINavigationController())
        
        let sut = LoginViewModel(gitHubService: mockService, keychain: mockKeychain, notificationCenter: mockNotificationCenter, userDefaults: mockUserDefaults)
        sut.coordinator = mockCoordinator
        
        //WHEN
        sut.goToLogin()
        
        //THEN
        XCTAssertTrue(mockCoordinator.isGoToLoginOnSafari)
    }
    
    func test_givenNothing_whenGoToSignUp_thenSuccess() {
        //GIVEN
        let mockService = MockGitHubService()
        let mockKeychain = MockKeychainSwift()
        let mockUserDefaults = MockUserDefaults()
        let mockNotificationCenter = MockNotificationCenter()
        let mockCoordinator = MockAuthCoordinator(navigationController: UINavigationController())
        
        let sut = LoginViewModel(gitHubService: mockService, keychain: mockKeychain, notificationCenter: mockNotificationCenter, userDefaults: mockUserDefaults)
        sut.coordinator = mockCoordinator
        
        //WHEN
        sut.goToSignUp()
        
        //THEN
        XCTAssertTrue(mockCoordinator.isGoToSignUpOnSafari)
    }
    
}
