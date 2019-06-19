//
//  LastFM+Image.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 17.06.19.
//

import Foundation

public extension LastFM {
    struct Image: Decodable {
        public let urlString: String
        public let size: Size
        
        enum CodingKeys: String, CodingKey {
            case urlString = "#text"
            case size
        }
        
        public enum Size: String, Decodable {
            case small, medium, large, extralarge, mega
        }
    }
}

public extension LastFM.Image {
    var url: URL? {
        return URL(string: urlString)
    }
}
