//
//  Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

class Resource<M> {
    let parse: (Data) throws -> M
    
    let baseURL: URL
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL {
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url(relativeTo: baseURL) else {
            fatalError("URL creation from components \(components) to baseURL \(baseURL) failed!")
        }
        
        return url
    }
    
    init(baseURL: URL, path: String, queryItems: [URLQueryItem], parse: @escaping (Data) throws -> M) {
        self.baseURL = baseURL
        self.path = path
        self.queryItems = queryItems
        self.parse = parse
    }
}
