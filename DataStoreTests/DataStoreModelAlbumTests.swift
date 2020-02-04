//
//  DataStoreModelAlbumTests.swift
//  DataStoreTests
//
//  Created by Markus Faßbender on 04.02.20.
//

import XCTest
import Models
import RealmSwift
@testable import DataStore

class DataStoreModelAlbumTests: XCTestCase {
    
    // MARK: Properties
    
    func testAlbumPrimaryKey() {
        XCTAssertEqual(Album.primaryKey(), "title")
    }
    
    // MARK: Mapping
    
    func testMapFromModel() {
        let artist = Models.Artist(name: "John Lennon")
        let album = Models.Album(title: "Welcome",
                                 artist: artist,
                                 imageURL: URL(string: "https://apple.com"),
                                 tracks: ["Lady"])
        
        let dataStoreAlbum = Album.from(model: album)
        
        XCTAssertEqual(dataStoreAlbum.title, "Welcome")
        XCTAssertNotNil(dataStoreAlbum.artist?.name, "John Lennon")
        XCTAssertEqual(dataStoreAlbum.imageURLString, "https://apple.com")
        XCTAssertEqual(dataStoreAlbum.tracks?.first, "Lady")
    }
    
    func testMapToModel() {
        let artist = Artist()
        artist.name = "John Lennon"
        
        let tracks = List<String>()
        tracks.append("Lady")
        
        let album = Album()
        album.artist = artist
        album.title = "Welcome"
        album.imageURLString = "https://apple.com"
        album.tracks = tracks
        
        let modelAlbum = album.toModel()
        
        XCTAssertEqual(modelAlbum.title, "Welcome")
        XCTAssertEqual(modelAlbum.artist.name, "John Lennon")
        XCTAssertEqual(modelAlbum.imageURL, URL(string: "https://apple.com"))
        XCTAssertEqual(modelAlbum.tracks?.first, "Lady")
    }
}
