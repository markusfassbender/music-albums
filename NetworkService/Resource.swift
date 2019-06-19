//
//  Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

public class Resource<M> {
    public let parse: (Data) throws -> M
    public let url: URL
    
    public init?(baseURL: URL, path: String, queryItems: [URLQueryItem], parse: @escaping (Data) throws -> M) {
        self.parse = parse
        
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url(relativeTo: baseURL) else {
            return nil
        }
        
        self.url = url
    }
    
    public init(url: URL, parse: @escaping (Data) throws -> M) {
        self.url = url
        self.parse = parse
    }
}
