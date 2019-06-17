//
//  Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

class Resource<M> {
    let parse: (Data) throws -> M
    let url: URL
    
    init?(baseURL: URL, path: String, queryItems: [URLQueryItem], parse: @escaping (Data) throws -> M) {
        self.parse = parse
        
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url(relativeTo: baseURL) else {
            return nil
        }
        
        self.url = url
    }
}
