//
//  ModelMappingProtocol.swift
//  DataStore
//
//  Created by Markus Faßbender on 20.06.19.
//

import Foundation

protocol ModelMappingProtocol {
    associatedtype StoreType
    associatedtype ModelType
    
    static func from(model: ModelType) -> StoreType
    func toModel() -> ModelType
}
