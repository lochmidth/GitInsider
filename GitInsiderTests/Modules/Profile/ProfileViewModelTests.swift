//
//  ProfileViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import XCTest
@testable import GitInsider

final class ProfileViewModelTests: XCTestCase {
    
    func test_givenUserIsAuthUser_whenConfigureProfileHeaderViewModel_thenReturnHeaderWithEditProfile() async {
        //GIVEN
        let sut = ProfileViewModel(user: mockUser1)
        sut.authLogin = mockUser1.login
        
        //WHEN
        do {
            let headerVM = try await sut.configureProfileHeaderViewModel()
            
            //THEN
            XCTAssertEqual(headerVM.config, .editProfile)
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func test_givenUserIsBeingfollowed_whenConfigureProfileHeaderViewModel_thenReturnHeaderWithFollowing() async {
        //GIVEN
        let mockService = MockGitHubService()
        mockService.isUserFollowing = true
        let sut = ProfileViewModel(user: mockUser2, gitHubService: mockService)
        sut.authLogin = mockUser1.login
        
        //WHEN
        do {
            let headerVM = try await sut.configureProfileHeaderViewModel()
            
            //THEN
            XCTAssertEqual(headerVM.config, .following)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenUserIsNotBeingfollowed_whenConfigureProfileHeaderViewModel_thenReturnHeaderWithFollowing() async {
        //GIVEN
        let mockService = MockGitHubService()
        mockService.isUserFollowing = false
        let sut = ProfileViewModel(user: mockUser2, gitHubService: mockService)
        sut.authLogin = mockUser1.login
        
        //WHEN
        do {
            let headerVM = try await sut.configureProfileHeaderViewModel()
            
            //THEN
            XCTAssertEqual(headerVM.config, .notFollowing)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenUsername_whenFollow_thenSuccess() async {
        //GIVEN
        let mockService = MockGitHubService()
        
        let sut = ProfileViewModel(user: mockUser1, gitHubService: mockService)
        
        //WHEN
        do {
            try await sut.follow(username: "jane_smith")
            
            //THEN
            XCTAssertTrue(mockService.isFollowCalled)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenUsername_whenUnfollow_thenSuccess() async {
        //GIVEN
        let mockService = MockGitHubService()
        
        let sut = ProfileViewModel(user: mockUser1, gitHubService: mockService)
        
        //WHEN
        do {
            try await sut.unfollow(username: "jane_smith")
            
            //THEN
            XCTAssertTrue(mockService.isUnfollowCalled)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenUsername_whenGetUserRepos_thenSuccessWithValidRepos() async {
        //GIVEN
        let mockService = MockGitHubService()
        
        let sut = ProfileViewModel(user: mockUser1, gitHubService: mockService)
        
        //WHEN
        do {
            try await sut.getUserRepos()
            
            //THEN
            XCTAssertEqual(sut.repos[0].name, "example-repo1")
            XCTAssertTrue(mockService.isGetUserReposCalled)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenIndexValidRepo_whenDidSelectRowAt_thenGoToSafari() {
        //GIVEN
        let mockCoordinator = MockHomeCoordinator(navigationController: UINavigationController(), user: mockUser1)
        
        let sut = ProfileViewModel(user: mockUser1)
        sut.coordinator = mockCoordinator
        sut.repos = [mockRepo1, mockRepo2]
        
        //WHEN
        sut.didSelectRowAt(index: 0)
        
        //THEN
        XCTAssertTrue(mockCoordinator.isGoToSafariCalled)
    }
}
