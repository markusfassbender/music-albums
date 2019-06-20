//
//  LastFM+Image.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 17.06.19.
//

import Foundation

public extension LastFM {
    struct Image: Decodable {
        public let url: URL?
        public let size: Size
        
        enum CodingKeys: String, CodingKey {
            case url = "#text"
            case size
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // try? is a workaround to avoid parsing issues. The API sometimes return invalid URLs like {"#text": ""}. 
            url = try? container.decode(URL.self, forKey: .url)
            size = try container.decode(Size.self, forKey: .size)
        }
        
        public enum Size: String, Decodable {
            case small, medium, large, extralarge, mega
        }
    }
}
