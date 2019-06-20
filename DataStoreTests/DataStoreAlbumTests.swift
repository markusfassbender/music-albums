//
//  DataStoreAlbumTests.swift
//  DataStoreTests
//
//  Created by Markus Faßbender on 20.06.19.
//

import XCTest
import Models
import RealmSwift

@testable import DataStore

class DataStoreAlbumTests: XCTestCase {
    private func temporaryDataStore(identifier: String) -> DataStore {
        let configuration = Realm.Configuration(inMemoryIdentifier: "testSaveAlbum")
        let realm = try! Realm(configuration: configuration)
        return DataStore(realm: realm)
    }
    
    func testSaveAlbum() {
        let artist = Models.Artist(name: "John Lennon")
        let album = Models.Album(title: "Welcome", artist: artist)
        
        let dataStore = temporaryDataStore(identifier: "testSaveAlbum")
        XCTAssertNoThrow(try dataStore.saveAlbum(album))
    }
    
    func testAllAlbumsEmpty() {
        let dataStore = temporaryDataStore(identifier: "testAllAlbumsEmpty")
        
        XCTAssertTrue(dataStore.allAlbumsSortedByTitle().isEmpty)
    }
    
    func testAllAlbumsCount() {
        let dataStore = temporaryDataStore(identifier: "testAllAlbumsCount")
        
        let artist = Models.Artist(name: "John Lennon")
        let welcomeAlbum = Models.Album(title: "Welcome", artist: artist)
        let goodbyeAlbum = Models.Album(title: "Goodbye", artist: artist)
        
        do {
            try dataStore.saveAlbum(welcomeAlbum)
            try dataStore.saveAlbum(goodbyeAlbum)
            let albums = dataStore.allAlbumsSortedByTitle()
            
            XCTAssert(albums.count == 2)
        } catch {
            XCTFail("test all albums should never call catch closure")
        }
    }
    
    func testAllAlbumsSortedByTitle() {
        let dataStore = temporaryDataStore(identifier: "testAllAlbumsSortedByTitle")
        
        let artist = Models.Artist(name: "John Lennon")
        let welcomeAlbum = Models.Album(title: "Welcome", artist: artist)
        let goodbyeAlbum = Models.Album(title: "Goodbye", artist: artist)
        
        do {
            try dataStore.saveAlbum(welcomeAlbum)
            try dataStore.saveAlbum(goodbyeAlbum)
            let albums = dataStore.allAlbumsSortedByTitle()
            
            XCTAssert(albums[0].title == "Goodbye")
            XCTAssert(albums[1].title == "Welcome")
        } catch {
            XCTFail("test all albums should never call catch closure")
        }
    }
}