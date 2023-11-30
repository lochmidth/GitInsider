//
//  SplashViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 29.11.2023.
//

import XCTest
@testable import GitInsider

final class SplashViewModelTests: XCTestCase {
    
    func test_givenNothing_whenGetCurrentUser_thenSuccessWithUser() async {
        //GIVEN
        let mockService = MockGitHubService()
        mockService.resultForUser = .success(mockUser1)
        
        let sut = SplashViewModel(gitHubService: mockService)
        
        //WHEN
        do {
            let fetchedUser = try await sut.getCurrentUser()
            
            //THEN
            XCTAssertTrue(mockService.isGetCurrentUserCalled)
            XCTAssertEqual(fetchedUser.login, "john_doe")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenExpiredDate_whenCheckAndRemoveExpiredAccessToken_thenDeleteToken() {
        //GIVEN
        let mockService = MockGitHubService()
        let mockUserDefaults = MockUserDefaults()
        let mockKeychain = MockKeychainSwift()
        let _ = mockKeychain.set("123456789abc", forKey: accessTokenInKeychain)
        let expirationDate = Date(timeIntervalSinceNow: -3600) // 1 hour passed
        mockUserDefaults.set(expirationDate, forKey: accessTokenExpirationKeyInDefaults)
        
        let sut = SplashViewModel(keychain: mockKeychain, gitHubService: mockService, userDefaults: mockUserDefaults)
        
        //WHEN
        sut.checkAndRemoveExpiredAccessToken()
        
        XCTAssertNil(mockUserDefaults.value(forKey: accessTokenExpirationKeyInDefaults))
        XCTAssertNil(mockKeychain.get(accessTokenInKeychain))
    }
    
    func test_givenValidDate_whenCheckAndRemoveExpiredAccessToken_thenKeepToken() {
        //GIVEN
        let mockService = MockGitHubService()
        let mockUserDefaults = MockUserDefaults()
        let mockKeychain = MockKeychainSwift()
        let _ = mockKeychain.set("123456789abc", forKey: accessTokenInKeychain)
        let expirationDate = Date(timeIntervalSinceNow: 3600) // 1 hour left
        mockUserDefaults.set(expirationDate, forKey: accessTokenExpirationKeyInDefaults)
        
        let sut = SplashViewModel(keychain: mockKeychain, gitHubService: mockService, userDefaults: mockUserDefaults)
        
        //WHEN
        sut.checkAndRemoveExpiredAccessToken()
        
        XCTAssertEqual(mockUserDefaults.value(forKey: accessTokenExpirationKeyInDefaults) as! Date, expirationDate)
        XCTAssertEqual(mockKeychain.get(accessTokenInKeychain), "123456789abc")
    }
    
    func test_givenValidAccessToken_whenCheckForAuth_thenFinishAuth() {
        //GIVEN
        let mockService = MockGitHubService()
        let mockUserDefaults = MockUserDefaults()
        let mockKeychain = MockKeychainSwift()
        let mockCoordinator = MockAuthCoordinator(navigationController: UINavigationController())
        
        let _ = mockKeychain.set("123456789abc", forKey: accessTokenInKeychain)
        
        mockService.resultForUser = .success(mockUser1)
        
        let sut = SplashViewModel(keychain: mockKeychain, gitHubService: mockService, userDefaults: mockUserDefaults)
        sut.coordinator = mockCoordinator
        
        let expectation = XCTestExpectation(description: "didFinishAuth")
        
        //WHEN
        sut.checkForAuth()
        
        //THEN
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 3.0)
        
        XCTAssertTrue(mockCoordinator.isDidFinishAuthCalled)
    }
    
    func test_givenEmptyAccessToken_whenCheckForAuth_thenGoToLoginPage() {
        let mockService = MockGitHubService()
        let mockUserDefaults = MockUserDefaults()
        let mockKeychain = MockKeychainSwift()
        let mockCoordinator = MockAuthCoordinator(navigationController: UINavigationController())
        
        let _ = mockKeychain.delete(accessTokenInKeychain)
        
        let sut = SplashViewModel(keychain: mockKeychain, gitHubService: mockService, userDefaults: mockUserDefaults)
        sut.coordinator = mockCoordinator
        
        //WHEN
        sut.checkForAuth()
        
        XCTAssertTrue(mockCoordinator.isGoToLoginPage)
    }
    
}
