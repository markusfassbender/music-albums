//
//  DataStore+Album.swift
//  DataStore
//
//  Created by Markus Faßbender on 20.06.19.
//

import Foundation
import Models

public extension DataStore {
    func saveAlbum(_ album: Models.Album) throws {
        let album = Album.from(model: album)
        
        try realm.write {
            realm.add(album)
        }
    }
    
    func deleteAlbum(_ album: Models.Album) {
        // TODO: Implement
    }
    
    func allAlbums() -> [Models.Album] {
        let albums = realm.objects(Album.self)
        return albums.map { $0.toModel() }
    }
}
