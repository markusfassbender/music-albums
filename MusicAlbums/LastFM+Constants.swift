//
//  LastFM+Constants.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import Foundation

struct LastFM { }

extension LastFM {
    struct Constants {
        static let baseURL: URL = URL(string: "https://ws.audioscrobbler.com")!
        static let path: String = "/2.0/"
        
        static var defaultQueryItems: [URLQueryItem] = {
            return [
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "api_key", value: NetworkConfig.shared.APIKey)
            ]
        }()
    }
}
