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
    
    func testArtistResourceAllFromEmptyData() {
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
    
    func testArtistResourceName() throws {
        let url = Bundle(for: type(of: self)).url(forResource: "mock_artist", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let resource = Artist.all(for: "John Lennon")
        
        let artists = try resource.parse(data)
        
        XCTAssertEqual(artists.first?.name, "John Lennon")
    }
    
    func testArtistResourceImage() throws {
        let url = Bundle(for: type(of: self)).url(forResource: "mock_artist", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let resource = Artist.all(for: "John Lennon")
        
        let artists = try resource.parse(data)
        
        XCTAssertEqual(artists.first?.image, nil)
    }
    
    func testArtistResourceImageURL() throws {
        let url = Bundle(for: type(of: self)).url(forResource: "mock_artist", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let resource = Artist.all(for: "John Lennon")
        
        let artists = try resource.parse(data)
        
        XCTAssertEqual(artists.first?.imageURL?.absoluteString, "https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png")
    }
}
