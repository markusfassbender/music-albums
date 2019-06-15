//
//  ArtistViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class ArtistViewController: UICollectionViewController {
    private let artist: Artist
    
    private var albumCancelToken: CancelToken?
    
    init(artist: Artist) {
        self.artist = artist
        
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        albumCancelToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadAlbums()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = artist.name
    }
    
    private func loadAlbums() {
        albumCancelToken?.cancel()
        
        let resource = Album.top(for: artist)
        let token = CancelToken()
        albumCancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) { result in
            switch result {
            case .success(let albums):
                print(albums)
            case .failure(let error):
                print(error)
            }
        }
    }
}
