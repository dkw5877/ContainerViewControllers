//
//  AppDelegate.swift
//  ContainerViewControllers
//
//  Created by user on 10/22/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator:Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        appCoordinator = AppCoordinator(tabBarController: window?.rootViewController as! TabBarController)
        appCoordinator?.start()
        Theme.apply()
        window?.makeKeyAndVisible()
        return true
    }
}

