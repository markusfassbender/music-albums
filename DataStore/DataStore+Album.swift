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
    
    func deleteAlbum(_ album: Models.Album) throws {
        guard let album = realm.object(ofType: Album.self, forPrimaryKey: album.title) else {
            throw Error.objectNotFound
        }
        
        try realm.write {
            realm.delete(album)
        }
    }
    
    func allAlbumsSortedByTitle() -> [Models.Album] {
        let albums = realm.objects(Album.self).sorted(byKeyPath: "title")
        return albums.map { $0.toModel() }
    }
    
    func containsAlbum(_ album: Models.Album) -> Bool {
        let objects = realm.objects(Album.self).filter("title == %@", album.title)
        return !objects.isEmpty
    }
}
