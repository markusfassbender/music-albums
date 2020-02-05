//
//  AlbumResourceTests.swift
//  NetworkServiceTests
//
//  Created by Markus Faßbender on 05.02.20.
//

import XCTest
import Models

@testable import NetworkService

class AlbumResourceTests: XCTestCase {
    
    // MARK: Top Albums
    
    func testAlbumResourceTopAlbumsFromEmptyData() {
        let artist = Artist(name: "John Lennon")
        let resource = Album.topAlbums(of: artist)
        
        XCTAssertThrowsError(try resource.parse(Data()))
    }
    
    func testAlbumResourceTopAlbumsParseAll() throws {
        let url = Bundle(for: type(of: self)).url(forResource: "mock_top_albums", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let artist = Artist(name: "John Lennon")
        let resource = Album.topAlbums(of: artist)
        
        let albums = try resource.parse(data)
        
        XCTAssertEqual(albums.count, 3)
    }
    
    // MARK: Album Details
    
    func testAlbumResourceDetailsFromEmptyData() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Imagine", artist: artist)
        let resource = Album.allDetails(for: album)
        
        XCTAssertThrowsError(try resource.parse(Data()))
    }
    
    func testAlbumResourceDetailsTracks() throws {
        let url = Bundle(for: type(of: self)).url(forResource: "mock_album_details", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Imagine", artist: artist)
        let resource = Album.allDetails(for: album)
        
        let albumDetails = try resource.parse(data)
        
        XCTAssertEqual(albumDetails.tracks?.count, 10)
    }
}
    
