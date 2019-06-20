//
//  Artist.swift
//  DataStore
//
//  Created by Markus Faßbender on 20.06.19.
//

import Foundation
import RealmSwift
import Models

class Artist: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var imageURLString: String? = nil
}

extension Artist: ModelMappingProtocol {
    typealias StoreType = Artist
    typealias ModelType = Models.Artist
    
    static func from(model: ModelType) -> StoreType {
        let artist = Artist()
        artist.name = model.name
        artist.imageURLString = model.imageURL?.absoluteString
        
        return artist
    }
    
    func toModel() -> ModelType {
        let imageURL: URL? = imageURLString != nil ? URL(string: imageURLString!)! : nil
        
        return Models.Artist(name: name,
                             image: nil,
                             imageURL: imageURL)
    }
}
