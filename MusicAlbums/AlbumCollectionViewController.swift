//
//  AlbumCollectionViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import NetworkService
import DataStore

class AlbumCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private struct Constant {
        static let layoutSpacing: CGFloat = 8
        static let numberOfCellsInRow: Int = 2
        static let additionalCellHeight: CGFloat = 100
    }
    
    private let artist: Artist
    private var albumsCancelToken: CancelToken?
    
    private lazy var dataSource: AlbumCollectionDataSource = {
        let dataSource = AlbumCollectionDataSource()
        dataSource.delegate = self
        return dataSource
    }()
    
    init(artist: Artist) {
        self.artist = artist
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constant.layoutSpacing
        layout.minimumLineSpacing = Constant.layoutSpacing
        layout.sectionInset = UIEdgeInsets(top: Constant.layoutSpacing, left: Constant.layoutSpacing, bottom: Constant.layoutSpacing, right: Constant.layoutSpacing)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        albumsCancelToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        loadAlbums()
    }
    
    private func setup() {
        collectionView.backgroundColor = .white
        title = artist.name
        
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCollectionDataSource.cellReuseIdentifier)
        collectionView.dataSource = dataSource
    }
    
    private func loadAlbums() {
        albumsCancelToken?.cancel()
        
        let resource = Album.topAlbums(of: artist)
        let token = CancelToken()
        albumsCancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) { result in
            switch result {
            case .success(let albums):
                self.dataSource.albums = albums
                
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            assertionFailure("layout must conform UICollectionViewFlowLayout")
            return .zero
        }
        
        let layoutInteritemSpacing = CGFloat(Constant.numberOfCellsInRow-1) * layout.minimumInteritemSpacing
        let layoutRowSpaces = layout.sectionInset.left + layout.sectionInset.right + layoutInteritemSpacing
        let collectionCellSize = collectionView.frame.size.width - layoutRowSpaces
        let width = collectionCellSize / CGFloat(Constant.numberOfCellsInRow)
        let height = width + Constant.additionalCellHeight
        
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = dataSource.album(at: indexPath)
        let viewController = AlbumDetailsViewController(album: album)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AlbumCollectionViewController: AlbumCollectionDelegate {
    func saveAlbum(at index: Int) {
        do {
            let album = dataSource.albums[index]
            try DataStore.shared.saveAlbum(album)
        } catch {
            assertionFailure("save album did fail")
        }
    }
    
    func deleteAlbum(at index: Int) {
        do {
            let album = dataSource.albums[index]
            try DataStore.shared.deleteAlbum(album)
        } catch {
            assertionFailure("delete album did fail")
        }
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
}
