//
//  AppDelegate.swift
//  Climatty
//
//  Created by Kateryna Tsysarenko on 30/09/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .red
        window?.rootViewController = UINavigationController(rootViewController: RootViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

