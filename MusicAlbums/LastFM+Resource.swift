//
//  LastFM+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import Foundation

public extension LastFM {
    class Resource<M>: NetworkService.Resource<M> {
        public init(queryItems: [URLQueryItem], parse: @escaping (Data) throws -> M) {
            let baseURL = Constants.baseURL
            let path = Constants.path
            let queryItems = queryItems + Constants.defaultQueryItems
            
            super.init(baseURL: baseURL,
                       path: path,
                       queryItems: queryItems,
                       parse: parse)!
        }
    }
}
