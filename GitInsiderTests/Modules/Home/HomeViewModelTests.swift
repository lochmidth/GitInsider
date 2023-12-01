//
//  HomeViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import XCTest
@testable import GitInsider

final class HomeViewModelTests: XCTestCase {
    
    func test_givenValidUser_whenVarAuthLogin_thenSuccess() {
        //GIVEN
        let sut = HomeViewModel(user: mockUser1)
        
        //WHEN
        let authLogin = sut.authLogin
        
        //THEN
        XCTAssertEqual(authLogin, "john_doe")
    }
    
    func test_givenNilUser_whenVarAuthLogin_thenDefaultValue() {
        //GIVEN
        let sut = HomeViewModel(user: nil)
        
        //WHEN
        let authLogin = sut.authLogin
        
        //THEN
        XCTAssertEqual(authLogin, "")
    }
    
    func test_givenValidUser_whenVarProfileImageUrl_thenSuccess() {
        //GIVEN
        let sut = HomeViewModel(user: mockUser1)
        
        //WHEN
        let imageUrl = sut.profileImageUrl
        
        //THEN
        XCTAssertEqual(imageUrl, URL(string: "https://example.com/avatar1.jpg"))
    }
    
    func test_givenNilUser_whenVarProfileImageUrl_thenDefault() {
        //GIVEN
        let sut = HomeViewModel(user: nil)
        
        //WHEN
        let imageUrl = sut.profileImageUrl
        
        //THEN
        XCTAssertEqual(imageUrl, URL(string: ""))
    }
    
    func test_givenValidUser_whenVarNameText_thenSuccess() {
        //GIVEN
        let sut = HomeViewModel(user: mockUser1)
        
        //WHEN
        let nameText = sut.nameText
        
        //THEN
        XCTAssertEqual(nameText, "Hi John!")
    }
    
    func test_givenNilUser_whenVarNameText_thenDefault() {
        //GIVEN
        let sut = HomeViewModel(user: nil)
        
        //WHEN
        let nameText = sut.nameText
        
        //THEN
        XCTAssertEqual(nameText, "Hi User!")
    }
    
    func test_givenNothing_whenHandleSignOut_thenSuccessWithSignOut() {
        //GIVEN
        let mockUser = mockUser1
        let mockService = MockGitHubService()
        let mockKeychain = MockKeychainSwift()
        let mockUserDefaults = MockUserDefaults()
        let mockCoordinator = MockHomeCoordinator(navigationController: UINavigationController(), user: mockUser)
        
        let sut = HomeViewModel(user: mockUser, gitHubService: mockService, keychain: mockKeychain, userDefaults: mockUserDefaults)
        sut.coordinator = mockCoordinator
        
        let _ = mockKeychain.set("Access Token", forKey: accessTokenInKeychain)
        mockUserDefaults.set("ExpirationDate", forKey: accessTokenExpirationKeyInDefaults)
        
        //WHEN
        sut.handleSignOut()
        
        //THEN
        XCTAssertNil(mockKeychain.get(accessTokenInKeychain))
        XCTAssertNil(mockUserDefaults.value(forKey: accessTokenExpirationKeyInDefaults))
        XCTAssertTrue(mockCoordinator.isSignOutCalled)
    }
    
    func test_givenValidUser_whenGoToProfile_thenSuccess() {
        //GIVEN
        let mockUser = mockUser1
        let mockCoordinator = MockHomeCoordinator(navigationController: UINavigationController(), user: mockUser)
        
        let sut = HomeViewModel(user: mockUser)
        sut.coordinator = mockCoordinator
        
        //WHEN
        sut.goToProfile(withUser: mockUser)
        
        //THEN
        XCTAssertTrue(mockCoordinator.isGoToProfileCalled)
    }
    
    func test_givenValidUsername_whenGetUserForUsername_thenSuccessWithUser() async {
        //GIVEN
        let mockUser = mockUser1
        let mockService = MockGitHubService()
        mockService.result = .success(mockUser2)
        
        let sut = HomeViewModel(user: mockUser, gitHubService: mockService)
        
        //WHEN
        do {
            let fetchedUser = try await sut.getUser(forUsername: "jane_smith")
            
            //THEN
            XCTAssertEqual(fetchedUser.login, "jane_smith")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenUsers_whenHandleCellImageVisibility_thenReturnTrue() {
        //GIVEN
        let sut = HomeViewModel(user: mockUser1)
        sut.users = mockUsers
        
        //WHEN
        let visibility = sut.handleCellImageVisibility()
        
        //THEN
        XCTAssertTrue(visibility)
    }
    
    func test_givenNothing_whenHandleCellImageVisibility_thenReturnFalse() {
        //GIVEN
        let sut = HomeViewModel(user: mockUser1)
        
        //WHEN
        let visibility = sut.handleCellImageVisibility()
        
        //THEN
        XCTAssertFalse(visibility)
    }
    
    func test_givenEmptyString_whenSearchUserForUsername_thenUsersReturnNil() async {
        //GIVEN
        let mockService = MockGitHubService()
        mockService.result = .success(mockUsers)
        let sut = HomeViewModel(user: mockUser1, gitHubService: mockService)
        
        //WHEN
        do {
            try await sut.searchUser(forUsername: "")
            
            //THEN
            XCTAssertNil(sut.users)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenValidString_whenSearchUserForUsername_thenUsersReturnFetchedUsers() async {
        //GIVEN
        let mockService = MockGitHubService()
        mockService.result = .success(mockUsers)
        let sut = HomeViewModel(user: mockUser1, gitHubService: mockService)
        
        //WHEN
        do {
            try await sut.searchUser(forUsername: "john_doe")
            
            //THEN
            XCTAssertEqual(sut.users?.items[0].login, "john_doe1")
            XCTAssertEqual(sut.users?.items[1].login, "john_doe2")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenValidIndex_whenDidSelectItemAt_thenGoToProfile() {
        //GIVEN
        let mockCoordinator = MockHomeCoordinator(navigationController: UINavigationController(), user: mockUser1)
        let mockService = MockGitHubService()
        mockService.result = .success(mockUser2)
        
        let sut = HomeViewModel(user: mockUser1, gitHubService: mockService)
        sut.coordinator = mockCoordinator
        sut.users = mockUsers
        
        let expectation = XCTestExpectation(description: "didSelectItemAt")
        
        //WHEN
        sut.didSelectItemAt(index: 0)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 3.0)
        
        XCTAssertTrue(mockService.isGetUserCalled)
        XCTAssertTrue(mockCoordinator.isGoToProfileCalled)
    }
}
