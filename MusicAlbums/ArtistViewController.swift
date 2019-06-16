//
//  ArtistViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class ArtistViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private struct Constant {
        static let reuseIdentifier: String = "ArtistViewController.reuseIdentifier"
        static let layoutSpacing: CGFloat = 8
        static let numberOfCellsInRow: Int = 2
        static let cellHeightRatio: CGFloat = 1.5
    }
    
    private let artist: Artist
    private var albumNames: [String] = []
    
    private var albumNamesCancelToken: CancelToken?
    
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
        albumNamesCancelToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadAlbums()
    }
    
    private func setup() {
        collectionView.backgroundColor = .white
        title = artist.name
        
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: Constant.reuseIdentifier)
    }
    
    private func loadAlbums() {
        albumNamesCancelToken?.cancel()
        
        let resource = Album.topAlbums(of: artist.name)
        let token = CancelToken()
        albumNamesCancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) { result in
            switch result {
            case .success(let albumNames):
                self.albumNames = albumNames
                
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
        return albumNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reuseIdentifier, for: indexPath)
        
        guard let albumCell = cell as? AlbumCell else {
            return cell
        }
        
        let image = UIImage(named: "image_placeholder")!
        let name = albumNames[indexPath.row]
        let artistName = artist.name
        let viewModel = AlbumCell.ViewModel(image: image, title: name, artistName: artistName)
        albumCell.configure(with: viewModel)
        
        return albumCell
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
        let height = width * Constant.cellHeightRatio
        
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumName = albumNames[indexPath.row]
        let viewController = AlbumDetailsViewController(albumName: albumName, artist: artist)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
