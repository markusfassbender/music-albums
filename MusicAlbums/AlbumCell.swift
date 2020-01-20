//
//  AlbumCell.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    private struct Constant {
        struct FavoriteButton {
            static let size = CGSize(width: 40.0, height: 25.0)
        }
    }
    
    private(set) weak var favoriteButton: UIButton?
    
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
        imageView.backgroundColor = Stylesheet.Color.imageBackground
        self.imageView = imageView
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Stylesheet.Color.title
        self.titleLabel = titleLabel
        
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.textColor = Stylesheet.Color.subTitle
        self.artistLabel = artistLabel
        
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(systemName: "heart")!, for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill")!, for: .selected)
        favoriteButton.contentHorizontalAlignment = .leading
        favoriteButton.tintColor = .black
        self.favoriteButton = favoriteButton
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = systemSpacing
        
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(favoriteButton)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: systemSpacing),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: systemSpacing),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -systemSpacing),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -systemSpacing),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: Constant.FavoriteButton.size.width),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constant.FavoriteButton.size.height),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with viewModel: AlbumCellViewModel) {
        imageView?.image = viewModel.image
        titleLabel?.text = viewModel.title
        artistLabel?.text = viewModel.artistName
        favoriteButton?.isSelected = viewModel.isFavorite
    }
}

// MARK: View Model

protocol AlbumCellViewModel {
    var image: UIImage? { get }
    var title: String { get }
    var artistName: String { get }
    var isFavorite: Bool { get }
}

extension AlbumCell {
    struct ViewModel: AlbumCellViewModel {
        let image: UIImage?
        let title: String
        let artistName: String
        let isFavorite: Bool
    }
}
