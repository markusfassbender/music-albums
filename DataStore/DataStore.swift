//
//  DataStore.swift
//  DataStore
//
//  Created by Markus Faßbender on 20.06.19.
//

import Foundation
import RealmSwift

public struct DataStore {
    public static let shared = DataStore()
    
    let realm: Realm
    
    public init() {
        let realm = try! Realm()
        self.init(realm: realm)
    }
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
}
