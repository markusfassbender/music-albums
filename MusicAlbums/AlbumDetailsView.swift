//
//  AlbumDetailsView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import UIKit

final class AlbumDetailsView: UIView {
    private(set) weak var stackView: UIStackView?
    
    private weak var imageView: UIImageView?
    private weak var titleLabel: UILabel?
    private weak var artistLabel: UILabel?
    private weak var tracksView: AlbumTracksView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = systemSpacing
        self.stackView = stackView
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        self.imageView = imageView
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        self.titleLabel = titleLabel
        
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.font = .preferredFont(forTextStyle: .title3)
        artistLabel.textColor = .darkGray
        self.artistLabel = artistLabel
        
        let tracksView = AlbumTracksView()
        tracksView.translatesAutoresizingMaskIntoConstraints = false
        self.tracksView = tracksView
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(tracksView)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with viewModel: AlbumDetailsViewModel) {
        imageView?.image = viewModel.image
        titleLabel?.text = viewModel.title
        artistLabel?.text = viewModel.artistName
        
        tracksView?.configure(with: viewModel.tracks)
    }
}

// MARK: View Model

protocol AlbumDetailsViewModel {
    var image: UIImage { get }
    var title: String { get }
    var artistName: String { get }
    var tracks: [AlbumTrackViewModel] { get }
}

extension AlbumDetailsView {
    struct ViewModel: AlbumDetailsViewModel {
        let image: UIImage
        let title: String
        let artistName: String
        let tracks: [AlbumTrackViewModel]
    }
}
