//
//  Album.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

struct Album {
    let title: String
    let artist: String
    let details: Details?
    
    init(title: String, artist: String, details: Details? = nil) {
        self.title = title
        self.artist = artist
        self.details = details
    }
}

extension Album {
    typealias Track = String
    
    struct Details {
        let releaseDate: Date
        let tracks: [Track]
    }
}
