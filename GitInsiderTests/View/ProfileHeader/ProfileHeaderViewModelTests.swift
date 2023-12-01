//
//  ProfileHeaderViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 1.12.2023.
//

import XCTest
@testable import GitInsider

final class ProfileHeaderViewModelTests: XCTestCase {

    func test_profileImageUrl_whenValidAvatarUrl() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let profileImageUrl = sut.profileImageUrl
        
        //THEN
        XCTAssertEqual(profileImageUrl, URL(string: "https://example.com/avatar1.jpg"))
    }
    
    func test_profileImageUrl_whenInvalidAvatarUrl() {
        //GIVEN
        var mockUser = mockUser1
        mockUser.avatarUrl = nil
        
        let sut = ProfileHeaderViewModel(user: mockUser, followingStatus: false)
        
        //WHEN
        let profileImageUrl = sut.profileImageUrl
        
        //THEN
        XCTAssertEqual(profileImageUrl, URL(string: ""))
    }
    
    func test_fullnameText_whenValidFullname() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let fullnameText = sut.fullnameText
        
        //THEN
        XCTAssertEqual(fullnameText, "John Doe")
    }
    
    func test_fullnameText_whenInvalidFullname() {
        //GIVEN
        var mockUser = mockUser1
        mockUser.name = nil
        
        let sut = ProfileHeaderViewModel(user: mockUser, followingStatus: false)
        
        //WHEN
        let fullnameText = sut.fullnameText
        
        //THEN
        XCTAssertEqual(fullnameText, "")
    }
    
    func test_usernameText() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let usernameText = sut.usernameText
        
        //THEN
        XCTAssertEqual(usernameText, "john_doe")
    }
    
    func test_bioText_whenValidBio() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let bioText = sut.bioText
        
        //THEN
        XCTAssertEqual(bioText, "Software Developer")
    }
    
    func test_bioText_whenInvalidBio() {
        //GIVEN
        var mockUser = mockUser1
        mockUser.bio = nil
        
        let sut = ProfileHeaderViewModel(user: mockUser, followingStatus: false)
        
        //WHEN
        let bioText = sut.bioText
        
        //THEN
        XCTAssertEqual(bioText, "")
    }
    
    func test_followerText() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let followerText = sut.followerText
        
        //THEN
        XCTAssertEqual(followerText, "100\nFollowers")
    }
    
    func test_followingText() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let followingText = sut.followingText
        
        //THEN
        XCTAssertEqual(followingText, "50\nFollowing")
    }
    
    func test_repoText() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let repoText = sut.repoText
        
        //THEN
        XCTAssertEqual(repoText, "20\nRepositories")
    }
    
    func test_editButtonImage_whenConfigEditProfile() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false, config: .editProfile)
        
        //WHEN
        let editButtonImage = sut.editButtonImage
        
        //THEN
        XCTAssertEqual(editButtonImage, UIImage(systemName: "square.and.pencil")?.withTintColor(.gitHubWhite, renderingMode: .alwaysOriginal))
    }
    
    func test_editButtonImage_whenConfigNotFollowing() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: false)
        
        //WHEN
        let editButtonImage = sut.editButtonImage
        
        //THEN
        XCTAssertEqual(editButtonImage, UIImage(systemName: "person.badge.plus")?.withTintColor(.gitHubGreen, renderingMode: .alwaysOriginal))
    }
    
    func test_editButtonImage_whenConfigFollowing() {
        //GIVEN
        let sut = ProfileHeaderViewModel(user: mockUser1, followingStatus: true)
        
        //WHEN
        let editButtonImage = sut.editButtonImage
        
        //THEN
        XCTAssertEqual(editButtonImage, UIImage(systemName: "person.badge.minus")?.withTintColor(.gitHubRed, renderingMode: .alwaysOriginal))
    }
}
