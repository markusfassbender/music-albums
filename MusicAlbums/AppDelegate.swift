//
//  AppDelegate.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        window.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [storedAlbumsViewController(), searchViewController()]
        tabBarController.tabBar.tintColor = .black
        
        window?.rootViewController = tabBarController
        
        return true
    }
    
    private func storedAlbumsViewController() -> UIViewController {
        let item = UITabBarItem(title: NSLocalizedString("title_main", comment: ""),
                     image: UIImage(systemName: "heart.fill"),
                     tag: 0)
        let viewController = StoredAlbumsViewController()
        viewController.tabBarItem = item
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func searchViewController() -> UIViewController {
        let item = UITabBarItem(title: NSLocalizedString("title_search", comment: ""),
                                image: UIImage(systemName: "magnifyingglass"),
                                tag: 1)
        let viewController = SearchViewController()
        viewController.tabBarItem = item
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}

