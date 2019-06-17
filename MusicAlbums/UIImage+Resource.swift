//
//  UIImage+Resource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 17.06.19.
//

import UIKit

extension UIImage {
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func image(from url: URL) -> Resource<UIImage> {
        return Resource(url: url, parse: { data in
            guard let image = UIImage(data: data) else {
                throw Error.invalidData
            }
            
            return image
        })
    }
}
