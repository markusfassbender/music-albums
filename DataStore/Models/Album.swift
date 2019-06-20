//
//  Album.swift
//  DataStore
//
//  Created by Markus Faßbender on 20.06.19.
//

import Foundation
import RealmSwift
import Models

class Album: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var artist: Artist = Artist()
    @objc dynamic var imageURLString: String? = nil
    @objc dynamic var tracks: [String]? = nil
    
    convenience init(album: Models.Album) {
        self.init()
        title = album.title
        artist = Artist(artist: album.artist)
        imageURLString = album.imageURL?.absoluteString
        tracks = album.tracks
    }
}
