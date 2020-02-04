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
    
    // MARK: Test Init
    
    func testInitName() {
        let name = "John Lennon"
        
        let artist = Artist(name: name,
                            image: nil,
                            imageURL: nil)
        
        XCTAssertEqual(artist.name, "John Lennon",
                       "the name should be 'John Lennon', but is '\(artist.name)'")
    }
    
    func testInitImage() {
        let name = "John Lennon"
        let image = UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!
        
        let artist = Artist(name: name,
                            image: image,
                            imageURL: nil)
        
        XCTAssertEqual(artist.image, image, "the images should be equal")
    }
    
    func testInitImageURL() {
        let name = "John Lennon"
        let url = URL(string: "http://google.de")!
        
        let artist = Artist(name: name,
                            image: nil,
                            imageURL: url)
        
        XCTAssertEqual(artist.imageURL, url, "the image urls should be equal")
    }
    
    // MARK: Test New Image
    
    func testNewImage() {
        let name = "John Lennon"
        let image = UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!
        
        let artist = Artist(name: name,
                            image: nil,
                            imageURL: nil)
        
        let artistWithImage = artist.new(with: image)
        
        XCTAssertEqual(artistWithImage.image, image, "image of new artist object should be equal to image")
    }
    
    func testNewKeepsName() {
        let name = "John Lennon"
        let image = UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!
        let artist = Artist(name: name,
                            image: nil,
                            imageURL: nil)
        
        let artistWithImage = artist.new(with: image)
        
        XCTAssertEqual(artistWithImage.name, "John Lennon", "name of new artist object should be kept")
    }
    
    func testNewKeepsImageURL() {
        let name = "John Lennon"
        let image = UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!
        let url = URL(string: "http://google.de")!
        let artist = Artist(name: name,
                            image: nil,
                            imageURL: url)
        
        let artistWithImage = artist.new(with: image)
        
        XCTAssertEqual(artistWithImage.imageURL, url, "url of new artist object should be kept")
    }
}
