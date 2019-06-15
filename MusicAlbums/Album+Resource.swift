//
//  Album+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

extension Album {
    static func top(for artist: Artist) -> Resource<[Album]> {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "method", value: "artist.gettopalbums"),
            URLQueryItem(name: "artist", value: artist.name),
            URLQueryItem(name: "autocorrect", value: "0"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "api_key", value: NetworkConfig.shared.APIKey)
        ]
        
        return Resource(path: "/2.0/", queryItems: queryItems, parse: { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(AlbumTopWrapper.self, from: data)
            return wrapper.topalbums.album.map {
                let title = $0.name
                let artist = $0.artist.name
                return Album(title: title, artist: artist)
            }
        })
    }
}

// MARK: Decodable API Wrapper

fileprivate struct AlbumTopWrapper: Decodable {
    fileprivate let topalbums: TopAlbums
    
    fileprivate struct TopAlbums: Decodable {
        fileprivate let album: [Album]
        
        fileprivate struct Album: Decodable {
            let name: String
            let artist: Artist
            
            fileprivate struct Artist: Decodable {
                let name: String
            }
        }
    }
}
