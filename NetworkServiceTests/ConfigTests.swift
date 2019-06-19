//
//  ConfigTests.swift
//  NetworkServiceTests
//
//  Created by Markus Faßbender on 19.06.19.
//

import XCTest
import NetworkService

class ConfigTests: XCTestCase {
    
    func testAPIKeyNotEmpty() {
        let key = Config.shared.APIKey
        XCTAssertFalse(key.isEmpty, "API Key should be not empty, but it is")
    }
}
