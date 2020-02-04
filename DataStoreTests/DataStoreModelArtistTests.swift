//
//  DataStoreModelArtistTests.swift
//  DataStoreTests
//
//  Created by Markus Faßbender on 04.02.20.
//

import XCTest
import Models
import RealmSwift

@testable import DataStore

class DataStoreModelArtistTests: XCTestCase {

    func testMapFromModel() {
        let artist = Models.Artist(name: "John Lennon", imageURL: URL(string: "https://apple.com"))
        
        let dataStoreArtist = Artist.from(model: artist)
        
        XCTAssertEqual(dataStoreArtist.name, "John Lennon")
        XCTAssertEqual(dataStoreArtist.imageURLString, "https://apple.com")
    }
    
    func testMapToModel() {
        let artist = Artist()
        artist.name = "John Lennon"
        artist.imageURLString = "https://apple.com"
        
        let modelArtist = artist.toModel()
        
        XCTAssertEqual(modelArtist.name, "John Lennon")
        XCTAssertEqual(modelArtist.imageURL, URL(string: "https://apple.com"))
    }
}
