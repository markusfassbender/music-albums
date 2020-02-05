//
//  UIImageResourceTests.swift
//  NetworkServiceTests
//
//  Created by Markus Faßbender on 04.02.20.
//

import XCTest
import UIKit

@testable import NetworkService

class UIImageResourceTests: XCTestCase {
    var bundle: Bundle {
        return .init(for: type(of: self))
    }
    
    func testImageNoData() {
        let resource = UIImage.image(from: URL(string: "https://apple.com")!)
        
        XCTAssertThrowsError(try resource.parse(Data())) {
            XCTAssertEqual($0 as? UIImage.Error, UIImage.Error.invalidData)
        }
    }
    
    func testImageValidData() throws {
        let resource = UIImage.image(from: URL(string: "https://apple.com")!)
        let imageData = UIImage(named: "pixel.png", in: bundle, compatibleWith: nil)!.pngData()!
        
        let image = try resource.parse(imageData)
        
        XCTAssertEqual(image.pngData(), imageData, "created image should be equal to provided png data")
    }

}
