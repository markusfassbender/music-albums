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
    @objc dynamic var artist: Artist? = nil
    @objc dynamic var imageURLString: String? = nil
    dynamic var tracks: List<String>? = nil
    
    override static func primaryKey() -> String? {
        return "title"
    }
}

extension Album: ModelMappingProtocol {
    typealias StoreType = Album
    typealias ModelType = Models.Album
    
    static func from(model: ModelType) -> StoreType {
        let album = Album()
        album.title = model.title
        album.artist = Artist.from(model: model.artist)
        album.imageURLString = model.imageURL?.absoluteString
        
        if let tracks = model.tracks {
            album.tracks = List<String>()
            album.tracks?.append(objectsIn: tracks)
        }
        
        return album
    }
    
    func toModel() -> ModelType {
        let imageURL: URL? = imageURLString != nil ? URL(string: imageURLString!)! : nil
        let tracks: [String]? = self.tracks?.map({ $0 })
        
        return Models.Album(title: title,
                            artist: artist!.toModel(),
                            image: nil,
                            imageURL: imageURL,
                            tracks: tracks)
    }
}

