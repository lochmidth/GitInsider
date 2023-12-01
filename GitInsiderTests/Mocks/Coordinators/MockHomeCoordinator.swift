//
//  MockHomeCoordinator.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import Foundation
@testable import GitInsider

class MockHomeCoordinator: HomeCoordinator {
    
    var isGoToHomeCalled = false
    override func goToHome() {
        isGoToHomeCalled = true
    }
    
    var isGoToProfileCalled = false
    override func goToProfile(withUser user: User) {
        isGoToProfileCalled = true
    }
    
    var isGoToSafariCalled = false
    override func goToSafari(withUrl url: URL) {
        isGoToSafariCalled = true
    }
    
    var isSignOutCalled = false
    override func signOut() {
        isSignOutCalled = true
    }
}
