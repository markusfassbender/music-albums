//
//  AlbumDetailsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    private let album: Album
    
    private weak var detailsView: AlbumDetailsView?
    
    init(album: Album) {
        self.album = album
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(with: album)
        displayDetails(of: album)
    }
    
    private func setup(with album: Album) {
        title = album.title
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
    
    private func displayDetails(of album: Album) {
        let image = UIImage(named: "image_placeholder")!
        let viewModel = AlbumDetailsView.ViewModel(image: image,
                                                   title: album.title,
                                                   artist: album.artist,
                                                   trackList: [])
        detailsView?.configure(with: viewModel)
    }
}
