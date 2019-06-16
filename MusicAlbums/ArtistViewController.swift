//
//  ArtistViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class ArtistViewController: UICollectionViewController {
    private struct Constant {
        static let reuseIdentifier: String = "ArtistViewController.reuseIdentifier"
    }
    
    private let artist: Artist
    private var albums: [Album] = []
    
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
        
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: Constant.reuseIdentifier)
    }
    
    private func loadAlbums() {
        albumCancelToken?.cancel()
        
        let resource = Album.top(for: artist)
        let token = CancelToken()
        albumCancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) { result in
            switch result {
            case .success(let albums):
                self.albums = albums
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reuseIdentifier, for: indexPath)
        
        guard let albumCell = cell as? AlbumCell else {
            return cell
        }
        
        let album = albums[indexPath.row]
        let image = UIImage(named: "image_placeholder")!
        let viewModel = AlbumCell.ViewModel(image: image, title: album.title, artist: album.artist)
        albumCell.configure(with: viewModel)
        
        return albumCell
    }
}
