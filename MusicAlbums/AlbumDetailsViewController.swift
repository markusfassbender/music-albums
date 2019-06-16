//
//  AlbumDetailsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    private let albumName: String
    private let artist: Artist
    
    private weak var detailsView: AlbumDetailsView?
    
    private var cancelToken: CancelToken?
    
    init(albumName: String, artist: Artist) {
        self.albumName = albumName
        self.artist = artist
        
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
        loadDetails()
    }
    
    private func setup() {
        title = albumName
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let detailsView = AlbumDetailsView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        self.detailsView = detailsView
        
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
        
        let resource = Album.album(for: albumName, of: artist)
        let token = CancelToken()
        cancelToken = token
        
        Webservice.shared.load(resource: resource, token: token) {
            switch $0 {
            case .success(let album):
                DispatchQueue.main.async {
                    self.displayDetails(of: album)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func displayDetails(of album: Album) {
        let image = UIImage(named: "image_placeholder")!
        
        let trackViewModels = album.tracks.enumerated().map { index, title -> AlbumTrackViewModel in
            let rank = index + 1
            return AlbumTracksView.ViewModel(rank: rank, title: title)
        }
        
        let viewModel = AlbumDetailsView.ViewModel(image: image,
                                                   title: album.title,
                                                   artistName: album.artist.name,
                                                   tracks: trackViewModels)
        detailsView?.configure(with: viewModel)
    }
}
