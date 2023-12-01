//
//  UserCellViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 1.12.2023.
//

import XCTest
@testable import GitInsider

final class UserCellViewModelTests: XCTestCase {
    
    func test_profileImageUrl() {
        //GIVEN
        let sut = UserCellViewModel(item: mockUsers.items[0])
        
        //WHEN
        let profileImageUrl = sut.profileImageUrl
        
        //THEN
        XCTAssertEqual(profileImageUrl, URL(string: "https://example.com/avatar1.jpg"))
    }
    
    func test_usernameText() {
        //GIVEN
        let sut = UserCellViewModel(item: mockUsers.items[0])
        
        //WHEN
        let usernameText = sut.usernameText
        
        //THEN
        XCTAssertEqual(usernameText, "john_doe1")
    }
    
    func test_givenTitleAndCell_whenCalculateFontSize_thenReturnFontSize() {
        //GIVEN
        let mockTitle = "Lorem Ipsum"
        let mockCell = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        let sut = UserCellViewModel(item: mockUsers.items[0])
        
        //WHEN
        let fontSize = sut.calculateFontSize(for: mockTitle, mockCell)
        
        //THEN
        XCTAssertGreaterThanOrEqual(fontSize, 0.0)
        XCTAssertLessThanOrEqual(fontSize, 16.0)
    }
}
