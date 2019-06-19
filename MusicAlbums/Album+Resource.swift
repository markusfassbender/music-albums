//
//  Album+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation
import Models

public extension Album {
    static func topAlbums(of artist: Artist) -> Resource<[Album]> {
        let queryItems = [
            URLQueryItem(name: "method", value: "artist.gettopalbums"),
            URLQueryItem(name: "artist", value: artist.name),
            URLQueryItem(name: "autocorrect", value: "0")
        ]
        
        return LastFM.Resource(queryItems: queryItems, parse: { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(AlbumTopWrapper.self, from: data)
            
            return wrapper.topalbums.album.map {
                let title = $0.name
                let image = $0.image?.first(where: { $0.size == .large }) ?? $0.image?.last
                let imageURL = image?.url
                return Album(title: title, artist: artist, image: nil, imageURL: imageURL, tracks: nil)
            }
        })
    }
    
    static func allDetails(for album: Album) -> Resource<Album> {
        let queryItems = [
            URLQueryItem(name: "method", value: "album.getInfo"),
            URLQueryItem(name: "artist", value: album.artist.name),
            URLQueryItem(name: "album", value: album.title),
            URLQueryItem(name: "autocorrect", value: "0")
        ]
        
        return LastFM.Resource(queryItems: queryItems, parse: { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(AlbumDetailWrapper.self, from: data)
            let tracks: [Album.Track] = wrapper.album.tracks.track.map { $0.name }
            
            return album.new(with: tracks)
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
            let image: [LastFM.Image]?
        }
    }
}

fileprivate struct AlbumDetailWrapper: Decodable {
    fileprivate let album: Album
    
    fileprivate struct Album: Decodable {
        let tracks: Tracks
        
        fileprivate struct Tracks: Decodable {
            let track: [Track]
            
            fileprivate struct Track: Decodable {
                let name: String
            }
        }
    }
}
