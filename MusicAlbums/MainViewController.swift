//
//  MainViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class MainViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = NSLocalizedString("title_main", comment: "")
        
        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearch))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc
    private func openSearch() {
        let viewController = SearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
