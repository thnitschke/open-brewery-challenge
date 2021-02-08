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
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = AppCoordinator(window: window)
        
        self.window = window
        self.appCoordinator = applicationCoordinator
        
        appCoordinator?.start()
        return true
    }

}
