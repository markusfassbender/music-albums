//
//  NetworkConfig.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

public struct Config: Decodable {
    public let APIKey: String
    
    public static let shared: Config = {
        let bundle = Bundle(for: BundleFinder.self)
        let url = bundle.url(forResource: "Keys", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(Config.self, from: data)
    }()
}

private class BundleFinder {}
