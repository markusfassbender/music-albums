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
    
    // MARK: Init
    
    func testInitName() {
        let artist = Artist(name: "John Lennon",
                            image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                            imageURL: URL(string: "http://google.de")!)
        
        XCTAssertEqual(artist.name, "John Lennon",
                       "After init with name 'John Lennon' the name should be 'John Lennon' but is '\(artist.name)'")
    }
    
    func testInitImage() {
        let artist = Artist(name: "John Lennon",
                            image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                            imageURL: URL(string: "http://google.de")!)
        
        XCTAssertEqual(artist.image, UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                       "After init with image the image should be equal but is not")
    }
    
    func testInitImageURL() {
        let artist = Artist(name: "John Lennon",
                            image: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                            imageURL: URL(string: "http://google.de")!)
        
        XCTAssertEqual(artist.imageURL, URL(string: "http://google.de")!,
                       "After init with image the image should be equal but is not")
    }
    
    // MARK: New Image
    
    func testNewImage() {
        let artist = Artist(name: "John Lennon",
                            image: nil,
                            imageURL: URL(string: "http://google.de")!)
        let artistWithImage = artist.new(with: UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!)
        
        XCTAssertEqual(artistWithImage.image, UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!,
                       "After creating new artist object with image the image should be equal but is not")
    }
}
