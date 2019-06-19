//
//  Artist.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

public struct Artist {
    public let name: String
    public let image: UIImage?
    public let imageURL: URL?
    
    public init(name: String, image: UIImage? = nil, imageURL: URL? = nil) {
        self.name = name
        self.image = image
        self.imageURL = imageURL
    }
}

public extension Artist {
    func new(with image: UIImage) -> Artist {
        return .init(name: self.name, image: image, imageURL: self.imageURL)
    }
}
