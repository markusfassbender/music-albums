//
//  LastFM+Constants.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import Foundation

public struct LastFM { }

public extension LastFM {
    struct Constants {
        public static let baseURL: URL = URL(string: "https://ws.audioscrobbler.com")!
        public static let path: String = "/2.0/"
        
        public static var defaultQueryItems: [URLQueryItem] = {
            return [
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "api_key", value: Config.shared.APIKey)
            ]
        }()
    }
}
