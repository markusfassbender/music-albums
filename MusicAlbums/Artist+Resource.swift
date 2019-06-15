//
//  SearchResult+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

extension Artist {
    static func all(for input: String) -> Resource<[Artist]> {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "method", value: "artist.search"),
            URLQueryItem(name: "artist", value: input),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "api_key", value: NetworkConfig.shared.APIKey)
        ]

        return Resource(path: "/2.0/", queryItems: queryItems, parse: { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(SearchResultWrapper.self, from: data)
            return wrapper.results.artistmatches.artist.map {
                let name = $0.name
                let image = $0.image?.first(where: { $0.size == .medium })
                let imageURL = image?.url
                return Artist(name: name, imageURL: imageURL)
            }
        })
    }
}

// MARK: Decodable API Wrapper

fileprivate struct SearchResultWrapper: Decodable {
    fileprivate let results: Results
    
    fileprivate struct Results: Decodable {
        fileprivate let artistmatches: ArtistMatches
        
        fileprivate struct ArtistMatches: Decodable {
            let artist: [Artist]
            
            fileprivate struct Artist: Decodable {
                let name: String
                let image: [Image]?
                
                fileprivate struct Image: Decodable {
                    let url: URL
                    let size: Size
                    
                    enum CodingKeys: String, CodingKey {
                        case url = "#text"
                        case size
                    }
                    
                    fileprivate enum Size: String, Decodable {
                        case small, medium, large, extralarge, mega
                    }
                }
            }
        }
    }
}
