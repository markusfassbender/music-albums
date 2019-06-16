//
//  Album+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

extension Album {
    static func topAlbums(of artist: Artist) -> Resource<[Album]> {
        let queryItems = [
            URLQueryItem(name: "method", value: "artist.gettopalbums"),
            URLQueryItem(name: "artist", value: artist.name),
            URLQueryItem(name: "autocorrect", value: "0")
        ]
        
        return LastFM.Resource(queryItems: queryItems) { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(AlbumTopWrapper.self, from: data)
            
            return wrapper.topalbums.album.map {
                Album(title: $0.name, artist: artist)
            }
        }
    }
    
    static func album(for albumName: String, of artist: Artist) -> Resource<Album> {
        let queryItems = [
            URLQueryItem(name: "method", value: "album.getInfo"),
            URLQueryItem(name: "artist", value: artist.name),
            URLQueryItem(name: "album", value: albumName),
            URLQueryItem(name: "autocorrect", value: "0")
        ]
        
        return LastFM.Resource(queryItems: queryItems, parse: { data in
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(AlbumDetailWrapper.self, from: data)
            let tracks: [Album.Track] = wrapper.album.tracks.track.map { $0.name }
            
            return Album(title: albumName, artist: artist, image: nil, imageURL: nil, tracks: tracks)
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
