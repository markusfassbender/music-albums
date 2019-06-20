//
//  StoredAlbumsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import DataStore

class StoredAlbumsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private struct Constant {
        static let reuseIdentifier: String = "StoredAlbumsViewController.reuseIdentifier"
        static let layoutSpacing: CGFloat = 8
        static let numberOfCellsInRow: Int = 1
        static let additionalCellHeight: CGFloat = 100
    }
    
    private lazy var dataSource: AlbumCollectionDataSource = {
        let dataSource = AlbumCollectionDataSource()
        dataSource.delegate = self
        return dataSource
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constant.layoutSpacing
        layout.minimumLineSpacing = Constant.layoutSpacing
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.albums = DataStore.shared.allAlbumsSortedByTitle()
        collectionView.reloadData()
    }
    
    private func setup() {
        collectionView.backgroundColor = .white
        title = NSLocalizedString("title_main", comment: "")
        
        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearch))
        navigationItem.rightBarButtonItem = item
        
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCollectionDataSource.cellReuseIdentifier)
        collectionView.dataSource = dataSource
    }
    
    // MARK: Collection View
    
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
    
    // MARK: Actions
    
    @objc
    private func openSearch() {
        let viewController = SearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension StoredAlbumsViewController: AlbumCollectionDelegate {
    func saveAlbum(_ album: Album) {
        do {
            try DataStore.shared.saveAlbum(album)
        } catch {
            assertionFailure("save album did fail")
        }
    }
    
    func deleteAlbum(_ album: Album) {
        do {
            try DataStore.shared.deleteAlbum(album)
        } catch {
            assertionFailure("delete album did fail")
        }
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
}
