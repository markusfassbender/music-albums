//
//  CancelToken.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

final class CancelToken {
    var handler: (() -> Void)?
    
    func cancel() {
        handler?()
    }
    
    init() {
    }
}
