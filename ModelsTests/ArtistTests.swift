//
//  ArtistTests.swift
//  ModelsTests
//
//  Created by Markus Faßbender on 19.06.19.
//

import XCTest
import Models

class ArtistTests: XCTestCase {
    var bundle: Bundle {
        return .init(for: type(of: self))
    }
    
    lazy var image = UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!
    lazy var url = URL(string: "http://google.de")!
    // MARK: Init
    
    func testInitName() {
        let artist = Artist(name: "John Lennon",
                            image: nil,
                            imageURL: nil)
        
        XCTAssertEqual(artist.name, "John Lennon",
                       "After init with name 'John Lennon' the name should be 'John Lennon' but is '\(artist.name)'")
    }
    
    func testInitImage() {
        let artist = Artist(name: "John Lennon",
                            image: image,
                            imageURL: nil)
        
        XCTAssertEqual(artist.image, image, "After init with image the image should be equal but is not")
    }
    
    func testInitImageURL() {
        let artist = Artist(name: "John Lennon",
                            image: nil,
                            imageURL: url)
        
        XCTAssertEqual(artist.imageURL, url, "After init with image the image should be equal but is not")
    }
    
    // MARK: New Image
    
    func testNewImage() {
        let artist = Artist(name: "John Lennon",
                            image: nil,
                            imageURL: nil)
        let artistWithImage = artist.new(with: image)
        
        XCTAssertEqual(artistWithImage.image, image, "After creating new artist object with image the image should be equal but is not")
    }
    
    func testNewKeepsName() {
        let artist = Artist(name: "John Lennon",
                            image: nil,
                            imageURL: nil)
        let artistWithImage = artist.new(with: image)
        
        XCTAssertEqual(artistWithImage.name, "John Lennon", "After creating new artist object the name should be kept, but is not")
    }
    
    func testNewKeepsImageURL() {
        let artist = Artist(name: "John Lennon",
                            image: nil,
                            imageURL: url)
        let artistWithImage = artist.new(with: image)
        
        XCTAssertEqual(artistWithImage.imageURL, url, "After creating new artist object the url should be kept, but is not")
    }
}
