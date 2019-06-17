//
//  Album.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

struct Album {
    typealias Track = String
    
    let title: String
    let artist: Artist
    let image: UIImage?
    let imageURL: URL?
    let tracks: [Track]?
    
    init(title: String, artist: Artist, image: UIImage? = nil, imageURL: URL? = nil, tracks: [Track]? = nil) {
        self.title = title
        self.artist = artist
        self.image = image
        self.imageURL = imageURL
        self.tracks = tracks
    }
}

extension Album {
    func new(with tracks: [Track]) -> Album {
        return .init(title: title,
                     artist: artist,
                     image: image,
                     imageURL: imageURL,
                     tracks: tracks)
    }
}
