//
//  GitHubServiceTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 28.11.2023.
//

import XCTest
@testable import GitInsider

final class GitHubServiceTests: XCTestCase {
    
    func test_givenValidCode_whenExchangeToken_thenSuccess() async {
        //GIVEN
        let code = "123456789valid"
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(mockAccessTokenResponse)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedAccessToken = try await sut.exchangeToken(code: code)
            
            //THEN
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertEqual(fetchedAccessToken.accessToken, "a1b2c3d4e5f6g7h8i9j0")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_givenInvalidCode_whenExchangeToken_thenFailWithError() async {
        //GIVEN
        let code = "123456789valid"
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.invalidCode)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fecthedAccessToken = try await sut.exchangeToken(code: code)
            
            //THEN
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertTrue(fecthedAccessToken.accessToken.isEmpty)
        } catch {
            XCTAssertEqual(error as! MockError, MockError.invalidCode)
        }
    }
    
    func test_givenValidAccessToken_whenGetCurrentUser_thenSuccessWithUser() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(mockUser1)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedUser = try await sut.getCurrentUser()
            
            //THEN
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertEqual(fetchedUser.login, "john_doe")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenInvalidAccessToken_whenGetCurrentUser_thenFailWithError() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.invalidAccessToken)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedUser = try await sut.getCurrentUser()
            
            //THEN
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertTrue(fetchedUser.login.isEmpty)
        } catch {
            XCTAssertEqual(error as! MockError, MockError.invalidAccessToken)
        }
    }
    
    func test_givenValidUsername_whenGetUserForUsername_thenSuccessWithUser() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(mockUser2)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedUser = try await sut.getUser(forUsername: "jane_smith")
            
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertEqual(fetchedUser.login, "jane_smith")
            XCTAssertEqual(fetchedUser.id, 789012)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenNonExistUsername_whenGetUserForUsername_thenFailWithError() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.invalidUsername)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedUser = try await sut.getUser(forUsername: "jane_smith")
            
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertTrue(fetchedUser.login.isEmpty)
        } catch {
            XCTAssertEqual(error as! MockError, MockError.invalidUsername)
        }
    }
    
    func test_givenValidUsername_whenSearchUser_thenSuccessWithUsers() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(mockUsers)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedUsers = try await sut.searchUser(forUsername: "john_d")
            
            //THEN
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertEqual(fetchedUsers.items[0].login, "john_doe1")
            XCTAssertEqual(fetchedUsers.items[1].login, "john_doe2")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenNonExistUsername_whenSearchUser_thenFailwithError() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.invalidUsername)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedUsers = try await sut.searchUser(forUsername: "nonExistUsername")
            
            //THEN
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertTrue(fetchedUsers.items.isEmpty)
        } catch {
            XCTAssertEqual(error as! MockError, MockError.invalidUsername)
        }
    }
    
    func test_givenValidUsername_whenGetUserReposWithUsername_thenSuccesswithRepos() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        let mockRepos: [Repo] = [mockRepo1, mockRepo2]
        mockNetworkManager.result = .success(mockRepos)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedRepos = try await sut.getUserRepos(username: "john_doe")
            
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertEqual(fetchedRepos[0].id, 987654)
            XCTAssertEqual(fetchedRepos[1].id, 123456)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenNonExistUsername_whenGetUserReposWithUsername_thenFailWithError() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.invalidUsername)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let fetchedRepos = try await sut.getUserRepos(username: "ğ")
            
            XCTAssertTrue(mockNetworkManager.isRequestCalled)
            XCTAssertTrue(fetchedRepos.isEmpty)
        } catch {
            XCTAssertEqual(error as! MockError, MockError.invalidUsername)
        }
    }
    
    func test_givenValidUsername_whenCheckIfUserFollowingUsername_thenSuccesswithTrue() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(true)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let result = try await sut.checkIfUserFollowing(username: "john_doe")
            
            XCTAssertTrue(mockNetworkManager.isrequestIsStatusValidCalled)
            XCTAssertTrue(result)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenNonExistUsername_whenCheckIfUserFollowingUsername_thenFailWithError() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = nil
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            let result = try await sut.checkIfUserFollowing(username: "ğ")
            
            XCTAssertTrue(mockNetworkManager.isrequestIsStatusValidCalled)
            XCTAssertNil(result)
        } catch {
            XCTAssertEqual(error as! MockError, MockError.someError)
        }
    }
    
    func test_givenValidUsername_whenFollowUsername_thenSuccessWithTrue() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(true)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            try await sut.follow(username: "john_doe")
            
            XCTAssertTrue(mockNetworkManager.isrequestIsStatusValidCalled)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenValidUsername_whenFollowUsername_thenFailWithFalse() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.someError)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            try await sut.follow(username: "john_doe")
           
        } catch {
            XCTAssertTrue(mockNetworkManager.isrequestIsStatusValidCalled)
            XCTAssertEqual(error as! GitHubError, GitHubError.followFailed)
        }
    }
    
    func test_givenValidUsername_whenUnFollowUsername_thenSuccessWithTrue() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(true)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            try await sut.unfollow(username: "john_doe")
            
            XCTAssertTrue(mockNetworkManager.isrequestIsStatusValidCalled)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_givenValidUsername_whenUnfollowUsername_thenFailWithFalse() async {
        //GIVEN
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(MockError.someError)
        
        let sut = GitHubService(networkManager: mockNetworkManager)
        
        //WHEN
        do {
            try await sut.unfollow(username: "john_doe")
           
        } catch {
            XCTAssertTrue(mockNetworkManager.isrequestIsStatusValidCalled)
            XCTAssertEqual(error as! GitHubError, GitHubError.unfollowFailed)
        }
    }
}
