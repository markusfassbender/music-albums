//
//  CollectionViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import DataStore
import SwiftUI

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private struct Constant {
        static let reuseIdentifier: String = "CollectionViewController.reuseIdentifier"
        static let layoutSpacing: CGFloat = 8
        static let numberOfCellsInRow: Int = 1
        static let additionalCellHeight: CGFloat = 100
    }
    
    // MARK: Properties
    
    private lazy var dataSource: AlbumSelectionDataSource = {
        let dataSource = AlbumSelectionDataSource()
        dataSource.delegate = self
        return dataSource
    }()
    
    private weak var emptyViewLabel: UILabel?
    
    // MARK: Initializer
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constant.layoutSpacing
        layout.minimumLineSpacing = Constant.layoutSpacing
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateAlbums(DataStore.shared.allAlbumsSortedByTitle())
        collectionView.reloadData()
    }
    
    private func setup() {
        title = NSLocalizedString("title_collection", comment: "")
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = Stylesheet.Color.viewBackground
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumSelectionDataSource.cellReuseIdentifier)
        collectionView.dataSource = dataSource
        
        let emptyViewLabel = loadEmptyView()
        emptyViewLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.emptyViewLabel = emptyViewLabel
        
        collectionView.backgroundView = emptyViewLabel
    }
    
    private func loadEmptyView() -> UILabel {
        let label = UILabel()
        label.text = NSLocalizedString("collection_is_empty", comment: "")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        
        return label
    }
    
    // MARK: Data logic
    
    private func updateAlbums(_ albums: [Album]) {
        dataSource.albums = albums
        emptyViewLabel?.isHidden = !albums.isEmpty
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
//        let viewController = AlbumDetailsViewController(album: album)
        
        let viewController = UIHostingController(rootView: AlbumDetailsSUIView(album: album))
        viewController.title = album.title
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CollectionViewController: AlbumSelectionDelegate {
    func saveAlbum(at index: Int) {
        assertionFailure("save album is not supported")
    }
    
    func deleteAlbum(at index: Int) {
        do {
            let album = dataSource.albums[index]
            try DataStore.shared.deleteAlbum(album)
        } catch {
            assertionFailure("delete album did fail")
        }
        
        collectionView.performBatchUpdates({
            var albums = dataSource.albums
            albums.remove(at: index)
            updateAlbums(albums)
            
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.deleteItems(at: [indexPath])
        }, completion: { _ in
            // Workaround to refresh all cell.tags to identify album objects in data source
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
        })
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
}
