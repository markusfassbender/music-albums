//
//  AlbumDetailsView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import UIKit

final class AlbumDetailsView: UIView {
    private(set) weak var stackView: UIStackView?
    private(set) weak var favoriteButton: UIButton?
    
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
        backgroundColor = Stylesheet.Color.viewBackground
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = systemSpacing
        self.stackView = stackView
        
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(systemName: "heart")!, for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill")!, for: .selected)
        favoriteButton.tintColor = .black
        self.favoriteButton = favoriteButton
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Stylesheet.Color.imageBackground
        self.imageView = imageView
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.textColor = Stylesheet.Color.title
        self.titleLabel = titleLabel
        
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.font = .preferredFont(forTextStyle: .title3)
        artistLabel.textColor = Stylesheet.Color.subTitle
        self.artistLabel = artistLabel
        
        let tracksView = AlbumTracksView()
        tracksView.translatesAutoresizingMaskIntoConstraints = false
        self.tracksView = tracksView
        
        addSubview(imageView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(tracksView)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: systemSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: systemSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -systemSpacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -systemSpacing),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with viewModel: AlbumDetailsViewModel) {
        imageView?.image = viewModel.image
        titleLabel?.text = viewModel.title
        artistLabel?.text = viewModel.artistName
        tracksView?.configure(with: viewModel.tracks)
        favoriteButton?.isSelected = viewModel.isFavorite
    }
}

// MARK: View Model

protocol AlbumDetailsViewModel {
    var image: UIImage? { get }
    var title: String { get }
    var artistName: String { get }
    var tracks: [AlbumTrackViewModel]? { get }
    var isFavorite: Bool { get }
}

extension AlbumDetailsView {
    struct ViewModel: AlbumDetailsViewModel {
        let image: UIImage?
        let title: String
        let artistName: String
        let tracks: [AlbumTrackViewModel]?
        let isFavorite: Bool
    }
}
