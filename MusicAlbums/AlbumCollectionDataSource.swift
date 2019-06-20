//
//  AlbumCollectionDataSource.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 20.06.19.
//

import UIKit
import Models
import NetworkService

protocol AlbumCollectionDelegate: class {
    func saveAlbum(_ album: Album)
    func deleteAlbum(_ album: Album)
    
    func reloadItems(at indexPaths: [IndexPath])
}

class AlbumCollectionDataSource: NSObject, UICollectionViewDataSource {
    static let cellReuseIdentifier: String = "AlbumCollectionDataSource.reuseIdentifier"
    
    var albums: [Album] = []
    weak var delegate: AlbumCollectionDelegate?
    
    private var imageDownloadTokens: [IndexPath: CancelToken] = [:]
    
    deinit {
        cancelAllImageDownloads()
    }
    
    // MARK: Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionDataSource.cellReuseIdentifier, for: indexPath)
        
        if let cell = cell as? AlbumCell {
            let album = self.album(at: indexPath)
            configureCell(cell, at: indexPath, with: album)
        }
        
        return cell
    }
    
    private func configureCell(_ cell: AlbumCell, at indexPath: IndexPath, with album: Album) {
        let viewModel = AlbumCell.ViewModel(image: album.image,
                                            title: album.title,
                                            artistName: album.artist.name,
                                            isFavorite: true)
        cell.configure(with: viewModel)
        
        cell.favoriteButton?.removeTarget(self, action: nil, for: .allEvents)
        cell.favoriteButton?.tag = indexPath.row
        cell.favoriteButton?.addTarget(self, action: #selector(storeAlbum(_:)), for: .touchUpInside)
        
        if album.image == nil, let url = album.imageURL {
            downloadImage(from: url, for: indexPath)
        }
    }
    
    private func downloadImage(from url: URL, for indexPath: IndexPath) {
        imageDownloadTokens[indexPath]?.cancel()
        
        let resource = UIImage.image(from: url)
        let token = CancelToken()
        imageDownloadTokens[indexPath] = token
        
        Webservice.shared.load(resource: resource, token: token) {
            switch $0 {
            case .success(let image):
                let album = self.albums[indexPath.row].new(with: image)
                self.albums[indexPath.row] = album
                
                DispatchQueue.main.async {
                    self.delegate?.reloadItems(at: [indexPath])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Actions
    
    @objc
    private func storeAlbum(_ button: UIButton) {
        let album = albums[button.tag]
        let isStored = button.isSelected
        
        if isStored {
            delegate?.deleteAlbum(album)
        } else {
            delegate?.saveAlbum(album)
        }
        
        button.isSelected = !button.isSelected
    }
    
    // MARK: Helpers
    
    private func cancelAllImageDownloads() {
        imageDownloadTokens.forEach {
            $0.value.cancel()
        }
    }
    
    func album(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
    }
}
