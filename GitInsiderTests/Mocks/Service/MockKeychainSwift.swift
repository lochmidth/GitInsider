//
//  MockKeychainSwift.swift
//  GitInsiderTests
//
//  Created by Alphan Ogün on 30.11.2023.
//

import Foundation
import KeychainSwift

class MockKeychainSwift: KeychainSwift {
    private var storage: [String: Data] = [:]

    override func set(_ value: String, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        storage[key] = value.data(using: .utf8)
        return true
    }

    override func get(_ key: String) -> String? {
        if let data = storage[key], let stringValue = String(data: data, encoding: .utf8) {
            return stringValue
        }
        return nil
    }

    override func delete(_ key: String) -> Bool {
        storage.removeValue(forKey: key)
        return true
    }
    
    func reset() {
        storage.removeAll()
    }
}
