//
//  CancelToken.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import Foundation

public final class CancelToken {
    public var handler: (() -> Void)?
    
    public func cancel() {
        handler?()
    }
    
    public init() {
    }
}
