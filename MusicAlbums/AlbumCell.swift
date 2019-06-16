//
//  AlbumCell.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    private weak var imageView: UIImageView?
    private weak var titleLabel: UILabel?
    private weak var artistLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .darkGray
        self.imageView = imageView
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        self.titleLabel = titleLabel
        
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.textColor = .darkGray
        self.artistLabel = artistLabel
        
        let labelLayoutGuide = UILayoutGuide()
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)
        contentView.addLayoutGuide(labelLayoutGuide)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            labelLayoutGuide.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: systemSpacing),
            labelLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: systemSpacing),
            labelLayoutGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -systemSpacing),
            labelLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -systemSpacing),
            
            titleLabel.topAnchor.constraint(equalTo: labelLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelLayoutGuide.trailingAnchor),
            
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: systemSpacing),
            artistLabel.leadingAnchor.constraint(equalTo: labelLayoutGuide.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: labelLayoutGuide.trailingAnchor),
            artistLabel.bottomAnchor.constraint(equalTo: labelLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with viewModel: AlbumCellViewModel) {
        imageView?.image = viewModel.image
        titleLabel?.text = viewModel.title
        artistLabel?.text = viewModel.artistName
    }
}

// MARK: View Model

protocol AlbumCellViewModel {
    var image: UIImage? { get }
    var title: String { get }
    var artistName: String { get }
}

extension AlbumCell {
    struct ViewModel: AlbumCellViewModel {
        let image: UIImage?
        let title: String
        let artistName: String
    }
}
