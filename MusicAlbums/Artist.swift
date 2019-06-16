//
//  Artist.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

struct Artist {
    let name: String
    let image: UIImage?
    let imageURL: URL?
    
    init(name: String, image: UIImage? = nil, imageURL: URL? = nil) {
        self.name = name
        self.image = image
        self.imageURL = imageURL
    }
}
