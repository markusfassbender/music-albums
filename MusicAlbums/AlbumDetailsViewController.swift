//
//  AlbumDetailsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import NetworkService
import DataStore

class AlbumDetailsViewController: UIViewController {
    private let album: Album
    
    private weak var detailsView: AlbumDetailsView?
    
    private var cancelToken: CancelToken?
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    deinit {
        cancelToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        displayAlbum(album)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if album.tracks == nil {
            loadDetails()
        }
    }
    
    private func setup() {
        title = album.title
        view.backgroundColor = Stylesheet.Color.viewBackground
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let detailsView = AlbumDetailsView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        self.detailsView = detailsView
        
        detailsView.favoriteButton?.addTarget(self, action: #selector(storeAlbum(_:)), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(detailsView)
        
        let constraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            detailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func loadDetails() {
        cancelToken?.cancel()
        
        let resource = Album.allDetails(for: album)
        let token = CancelToken()
        cancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) {
            switch $0 {
            case .success(let album):
                DispatchQueue.main.async {
                    self.displayAlbum(album)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func displayAlbum(_ album: Album) {
        let trackViewModels = album.tracks?.enumerated().map { index, title -> AlbumTrackViewModel in
            let rank = index + 1
            return AlbumTracksView.ViewModel(rank: rank, title: title)
        }
        let isFavorite = DataStore.shared.containsAlbum(album)
        
        let viewModel = AlbumDetailsView.ViewModel(image: album.image,
                                                   title: album.title,
                                                   artistName: album.artist.name,
                                                   tracks: trackViewModels,
                                                   isFavorite: isFavorite)
        detailsView?.configure(with: viewModel)
    }
    
    
    @objc private func storeAlbum(_ button: UIButton) {
        let isStored = button.isSelected
        
        do {
            if isStored {
                try DataStore.shared.deleteAlbum(album)
            } else {
                try DataStore.shared.saveAlbum(album)
            }
        } catch {
            fatalError("album can not be stored!")
        }
        
        button.isSelected = !button.isSelected
    }
}
