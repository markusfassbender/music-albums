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
    
    convenience init(artist: Models.Artist) {
        self.init()
        name = artist.name
        imageURLString = artist.imageURL?.absoluteString
    }
}
