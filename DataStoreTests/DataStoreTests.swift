//
//  DataStoreTests.swift
//  DataStoreTests
//
//  Created by Markus Faßbender on 20.06.19.
//

import XCTest
import RealmSwift

@testable import DataStore

class DataStoreTests: XCTestCase {

    func testInit() {
        XCTAssertNoThrow(try DataStore())
    }
    
    func testInitWithRealm() throws {
        let realm = try Realm()

        let dataStore = DataStore(realm: realm)

        XCTAssertEqual(dataStore.realm, realm, "realm object should be equal")
    }
    
    func testDeleteAll() throws {
        
        let dataStore = try DataStore()
        
        XCTAssertNoThrow(try dataStore.deleteAll())
    }
}
