//
//  SearchResult+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

extension Artist {
    static func all(for input: String) -> Resource<[Artist]> {
        let queryItems = [
            URLQueryItem(name: "method", value: "artist.search"),
            URLQueryItem(name: "artist", value: input)
        ]

        return LastFM.Resource(queryItems: queryItems, parse: { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(ArtistAllWrapper.self, from: data)
            return wrapper.results.artistmatches.artist.map {
                let name = $0.name
                let image = $0.image?.first(where: { $0.size == .medium }) ?? $0.image?.last
                let imageURL = image?.url
                return Artist(name: name, image: nil, imageURL: imageURL)
            }
        })
    }
}

// MARK: Decodable API Wrapper

fileprivate struct ArtistAllWrapper: Decodable {
    fileprivate let results: Results
    
    fileprivate struct Results: Decodable {
        fileprivate let artistmatches: ArtistMatches
        
        fileprivate struct ArtistMatches: Decodable {
            let artist: [Artist]
            
            fileprivate struct Artist: Decodable {
                let name: String
                let image: [LastFM.Image]?
            }
        }
    }
}
