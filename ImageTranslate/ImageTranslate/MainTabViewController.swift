//
//  MainTabViewController.swift
//  ImageTranslate
//
//  Created by Aaron Cleveland on 9/9/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbarController()
    }
    
    private func configureTabbarController() {
        let capture = CameraViewController()
        let settings = SettingsViewController()
        let saved = SavedViewController()
        
        let nav1 = templateNavigationController(image: UIImage(systemName: "bookmark.fill"), rootViewController: saved)
        let nav2 = templateNavigationController(image: UIImage(systemName: "camera.on.rectangle.fill"), rootViewController: capture)
        let nav3 = templateNavigationController(image: UIImage(systemName: "gear"), rootViewController: settings)
        
        viewControllers = [nav1, nav2, nav3]
    }
    
    private func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .systemBackground
        return nav
    }

}
