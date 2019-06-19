//
//  Album.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

public struct Album {
    public typealias Track = String
    
    public let title: String
    public let artist: Artist
    public let image: UIImage?
    public let imageURL: URL?
    public let tracks: [Track]?
    
    public init(title: String, artist: Artist, image: UIImage? = nil, imageURL: URL? = nil, tracks: [Track]? = nil) {
        self.title = title
        self.artist = artist
        self.image = image
        self.imageURL = imageURL
        self.tracks = tracks
    }
}

public extension Album {
    func new(with tracks: [Track]) -> Album {
        return .init(title: title,
                     artist: artist,
                     image: image,
                     imageURL: imageURL,
                     tracks: tracks)
    }
    
    func new(with image: UIImage) -> Album {
        return .init(title: title,
                     artist: artist,
                     image: image,
                     imageURL: imageURL,
                     tracks: tracks)
    }
}
