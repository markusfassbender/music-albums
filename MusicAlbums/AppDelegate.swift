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
    
    private let itemInstantiator = TabBarItemInstantiator()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        window.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            itemInstantiator.viewController(of: .collection),
            itemInstantiator.viewController(of: .search)
        ]
        tabBarController.tabBar.tintColor = Stylesheet.Color.defaultTint
        
        window?.rootViewController = tabBarController
        
        return true
    }
}

