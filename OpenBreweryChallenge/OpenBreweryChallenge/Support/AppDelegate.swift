//
//  AppDelegate.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 05/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController()
        
        applicationCoordinator = AppCoordinator(navigationController: navController)
        applicationCoordinator?.start()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }

}
