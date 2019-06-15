//
//  Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

private struct ResourceConstant {
    static let scheme = "https"
    static let host = "ws.audioscrobbler.com"
}

struct Resource<M> {
    let parse: (Data) throws -> M
    
    let queryItems: [URLQueryItem]
    let path: String
    
    var url: URL {
        var components = URLComponents()
        components.scheme = ResourceConstant.scheme
        components.host = ResourceConstant.host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            fatalError("Unable to create URL components from \(components)")
        }
        
        return url
    }
    
    init(path: String, queryItems: [URLQueryItem], parse: @escaping (Data) throws -> M) {
        self.path = path
        self.queryItems = queryItems
        self.parse = parse
    }
}
