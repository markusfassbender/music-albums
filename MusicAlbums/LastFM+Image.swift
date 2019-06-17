//
//  LastFM+Image.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 17.06.19.
//

import Foundation

extension LastFM {
    struct Image: Decodable {
        let urlString: String
        let size: Size
        
        enum CodingKeys: String, CodingKey {
            case urlString = "#text"
            case size
        }
        
        enum Size: String, Decodable {
            case small, medium, large, extralarge, mega
        }
    }
}

extension LastFM.Image {
    var url: URL? {
        return URL(string: urlString)
    }
}
