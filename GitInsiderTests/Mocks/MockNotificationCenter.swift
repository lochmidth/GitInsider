//
//  MockNotificationCenter.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import Foundation

class MockNotificationCenter: NotificationCenter {
    
    var isAddObserverCalled = false
    override func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        isAddObserverCalled = true
    }
    
    var isPostCalled = false
    override func post(name: NSNotification.Name, object: Any?, userInfo: [AnyHashable: Any]?) {
        isPostCalled = true
    }
    
    var isRemoveObserverCalled = false
    override func removeObserver(_ observer: Any, name: NSNotification.Name?, object: Any?) {
        isRemoveObserverCalled = true
    }
}
