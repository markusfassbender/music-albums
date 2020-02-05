//
//  TabTests.swift
//  MusicAlbumsTests
//
//  Created by Markus Faßbender on 05.02.20.
//

import XCTest
@testable import MusicAlbums

class TabTests: XCTestCase {
    
    func testPositionCollection() {
        XCTAssertEqual(Tab.collection.position, 0)
    }
    
    func testPositionSearch() {
        XCTAssertEqual(Tab.search.position, 1)
    }
}
