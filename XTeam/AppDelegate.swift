//
//  AppDelegate.swift
//  XTeam
//
//  Created by Justin Lennox on 4/29/20.
//  Copyright © 2020 Justin Lennox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavController = UINavigationController(rootViewController: TileViewController())
        rootNavController.navigationBar.barStyle = .black
        rootNavController.navigationBar.isHidden = true
        self.window?.rootViewController = rootNavController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

