//
//  Tab.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 21.01.20.
//

import Foundation

enum Tab {
    case collection
    case search
    
    var position: Int {
        switch self {
        case .collection:
            return 0
        case .search:
            return 1
        }
    }
}
