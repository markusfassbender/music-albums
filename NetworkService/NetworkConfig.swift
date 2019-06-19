//
//  NetworkConfig.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

public struct NetworkConfig: Decodable {
    public let APIKey: String
    
    public static let shared: NetworkConfig = {
        let bundle = Bundle(for: BundleFinder.self)
        let url = bundle.url(forResource: "Keys", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(NetworkConfig.self, from: data)
    }()
}

private class BundleFinder {}
