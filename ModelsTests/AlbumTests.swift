//
//  AlbumTests.swift
//  ModelsTests
//
//  Created by Markus Faßbender on 19.06.19.
//

import XCTest
import Models

class AlbumTests: XCTestCase {
    var bundle: Bundle {
        return .init(for: type(of: self))
    }
    
    // MARK: Init
    
    func testInitTitle() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        
        
        XCTAssertEqual(album.title, "Welcome",
                       "After init the title should be 'Welcome' but is '\(album.title)'")
    }
    
    func testInitArtist() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        
        
        XCTAssertEqual(album.artist.name, artist.name,
                       "After init the artist name should be 'John Lennon' but is '\(artist.name)'")
    }
    
    func testInitImage() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        
        
        XCTAssertEqual(album.image, UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                       "After init with image the image should be equal but is not")
    }
    
    func testInitImageURL() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        
        
        XCTAssertEqual(album.imageURL, URL(string: "http://google.de")!,
                       "After init the image url should be 'http://google.de' equal but is \(String(describing: album.imageURL?.absoluteString))")
    }
    
    func testInitTracks() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        
        
        XCTAssertEqual(album.tracks, ["first track", "second track"],
                       "After init the tracks should be '[\"first track\", \"second track\"]' equal but is \(String(describing: album.tracks))")
    }
    
    // MARK: New with tracks
    
    func testNewWithTracks() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        let albumWithNewTracks = album.new(with: ["another one"])
        
        
        XCTAssertEqual(albumWithNewTracks.tracks, ["another one"],
                       "After new with tracks the tracks should be '[\"another one\"]' but is '\(String(describing: albumWithNewTracks.tracks))'")
    }
    
    // MARK: New with image
    
    func testNewWithImage() {
        let artist = Artist(name: "John Lennon")
        let album = Album(title: "Welcome",
                          artist: artist,
                          image: nil,
                          imageURL: URL(string: "http://google.de")!,
                          tracks: ["first track", "second track"])
        let albumWithNewImage = album.new(with: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!)
        
        
        XCTAssertEqual(albumWithNewImage.image, UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                       "After new with tracks the image should be equal but is not")
    }
}
