//
//  ArtistCell.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import UIKit

final class ArtistCell: UITableViewCell {
    private struct Constant {
        static let minimumHeight: CGFloat = 60
    }
    
    private weak var artistImageView: UIImageView?
    private weak var artistNameLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let artistImageView = UIImageView()
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        artistImageView.contentMode = .scaleAspectFill
        artistImageView.backgroundColor = .darkGray
        self.artistImageView = artistImageView
        
        let artistNameLabel = UILabel()
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.numberOfLines = 2
        artistNameLabel.font = .preferredFont(forTextStyle: .body)
        artistNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        self.artistNameLabel = artistNameLabel
        
        contentView.addSubview(artistImageView)
        contentView.addSubview(artistNameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            artistImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            artistImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            artistImageView.widthAnchor.constraint(equalTo: artistImageView.heightAnchor),
            artistImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.minimumHeight),
            
            artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            artistNameLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: systemSpacing),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -systemSpacing),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with viewModel: ArtistCellViewModel) {
        artistImageView?.image = viewModel.image
        artistNameLabel?.text = viewModel.artistName
    }
}

// MARK: View Model

protocol ArtistCellViewModel {
    var image: UIImage? { get }
    var artistName: String { get }
}

extension ArtistCell {
    struct ViewModel: ArtistCellViewModel {
        let image: UIImage?
        let artistName: String
    }
}

