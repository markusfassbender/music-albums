//
//  AlbumTracksView.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 16.06.19.
//

import UIKit

final class AlbumTracksView: UIView {
    private weak var titleLabel: UILabel?
    private weak var stackView: UIStackView?
    
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
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        self.titleLabel = titleLabel
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = systemSpacing
        self.stackView = stackView
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: systemSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: systemSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with viewModels: [AlbumTrackViewModel]?) {
        titleLabel?.text = NSLocalizedString("tracks", comment: "")
        
        stackView?.arrangedSubviews.forEach {
            stackView?.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        viewModels?.forEach {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .preferredFont(forTextStyle: .body)
            label.text = "\($0.rank) \($0.title)"
            stackView?.addArrangedSubview(label)
        }
    }
}

// MARK: View Model

protocol AlbumTrackViewModel {
    var rank: Int { get }
    var title: String { get }
}

extension AlbumTracksView {
    struct ViewModel: AlbumTrackViewModel {
        let rank: Int
        let title: String
    }
}
