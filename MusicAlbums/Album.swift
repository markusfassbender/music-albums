//
//  Album.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

struct Album {
    typealias Track = String
    
    let title: String
    let artist: Artist
    let tracks: [Track]
}
