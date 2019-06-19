//
//  NetworkConfigTests.swift
//  NetworkServiceTests
//
//  Created by Markus Faßbender on 19.06.19.
//

import XCTest
import NetworkService

class NetworkConfigTests: XCTestCase {
    
    func testAPIKeyNotEmpty() {
        let key = NetworkConfig.shared.APIKey
        XCTAssertFalse(key.isEmpty, "API Key should be not empty, but it is")
    }
}
