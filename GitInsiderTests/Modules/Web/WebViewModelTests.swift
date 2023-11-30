//
//  WebViewModelTests.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import XCTest
@testable import GitInsider

final class WebViewModelTests: XCTestCase {

    func test_givenValidUrl_whenHandleCallback_thenSuccessWithCode() {
        //GIVEN
        let mockOAuthManager = MockOAuthManager()
        mockOAuthManager.result = .success("123456789Code")
        let mockNotificationCenter = MockNotificationCenter()
        
        let sut = WebViewModel(oAuthManager: mockOAuthManager, notificationCenter: mockNotificationCenter)
        
        let expectation = XCTestExpectation(description: "DidHandleCallback")
        
        //WHEN
        sut.handleCallback(fromUrl: URL(string: gitHubRedirectUri)!)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 3.0)
        
        XCTAssertTrue(mockOAuthManager.ishandleCallBackCalled)
        XCTAssertTrue(mockNotificationCenter.isPostCalled)
    }
}
