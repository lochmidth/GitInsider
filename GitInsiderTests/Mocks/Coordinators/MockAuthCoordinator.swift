//
//  MockAuthCoordinator.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import Foundation
@testable import GitInsider
import UIKit

class MockAuthCoordinator: AuthCoordinator {
    
    override func start() {
        print("MockCoordinator started.")
    }
    
    var isDidFinishAuthCalled = false
    override func didFinishAuth(withUser user: User) {
        isDidFinishAuthCalled = true
    }
    
    var isGoToLoginPage = false
    override func goToLoginPage() {
        isGoToLoginPage = true
    }
    
    var isGoToLoginOnSafari = false
    override func goToLoginOnSafari() {
        isGoToLoginOnSafari = true
    }
    
    var isGoToSignUpOnSafari = false
    override func goToSignUpOnSafari() {
        isGoToSignUpOnSafari = true
    }
}
