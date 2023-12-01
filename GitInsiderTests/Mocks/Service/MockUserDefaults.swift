//
//  MockUserDefaults.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import Foundation

class MockUserDefaults: UserDefaults {
    private var storage: [String: Any] = [:]

    var isSetCalled = false
    override func set(_ value: Any?, forKey defaultName: String) {
        isSetCalled = true
        storage[defaultName] = value
    }

    var isValueCalled = false
    override func value(forKey defaultName: String) -> Any? {
        isValueCalled = true
        return storage[defaultName]
    }

    var isRemoveObjectCalled = false
    override func removeObject(forKey defaultName: String) {
        isRemoveObjectCalled = true
        storage.removeValue(forKey: defaultName)
    }

    func reset() {
        storage.removeAll()
    }
}
