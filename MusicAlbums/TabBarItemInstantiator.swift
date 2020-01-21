//
//  SceneInstantiator.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 21.01.20.
//

import UIKit

final class TabBarItemInstantiator {
    func viewController(of tab: Tab) -> UIViewController {
        let viewController: UIViewController
        
        switch tab {
        case .collection:
            viewController = collectionViewController(itemTag: tab.position)
        case .search:
            viewController = searchViewController(itemTag: tab.position)
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func collectionViewController(itemTag: Int) -> UIViewController {
        let item = UITabBarItem(title: NSLocalizedString("title_collection", comment: ""),
                                image: UIImage(systemName: "heart.fill"),
                                tag: itemTag)
        let viewController = StoredAlbumsViewController()
        viewController.tabBarItem = item
        
        return viewController
    }
    
    private func searchViewController(itemTag: Int) -> UIViewController {
        let item = UITabBarItem(title: NSLocalizedString("title_search", comment: ""),
                                image: UIImage(systemName: "magnifyingglass"),
                                tag: itemTag)
        let viewController = SearchViewController()
        viewController.tabBarItem = item
        
        return viewController
    }
}
