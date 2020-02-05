//
//  ArtistResourceTests.swift
//  NetworkServiceTests
//
//  Created by Markus Faßbender on 05.02.20.
//

import XCTest
import Models

@testable import NetworkService

class ArtistResourceTests: XCTestCase {
    
    func testArtistResourceAllThrowsException() {
        let resource = Artist.all(for: "John Lennon")
        XCTAssertThrowsError(try resource.parse(Data()))
    }
    
    func testArtistResourceAllParseSuccessfull() throws {
        let url = Bundle(for: type(of: self)).url(forResource: "mock_artist", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let resource = Artist.all(for: "John Lennon")
        
        let artists = try resource.parse(data)
        
        XCTAssertEqual(artists.count, 2)
    }
}
