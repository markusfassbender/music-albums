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
    private weak var tracksStackView: UIStackView?
    
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
        self.titleLabel = titleLabel
        
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        self.artistLabel = artistLabel
        
        let tracksStackView = UIStackView()
        tracksStackView.translatesAutoresizingMaskIntoConstraints = false
        tracksStackView.axis = .vertical
        tracksStackView.alignment = .fill
        tracksStackView.distribution = .equalSpacing
        tracksStackView.spacing = systemSpacing
        self.tracksStackView = tracksStackView
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(tracksStackView)
        
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
        // TODO: update track list
    }
}

// MARK: View Model

protocol AlbumDetailsViewModel {
    var image: UIImage { get }
    var title: String { get }
    var artistName: String { get }
    var tracks: [String] { get }
}

extension AlbumDetailsView {
    struct ViewModel: AlbumDetailsViewModel {
        let image: UIImage
        let title: String
        let artistName: String
        let tracks: [String]
    }
}
