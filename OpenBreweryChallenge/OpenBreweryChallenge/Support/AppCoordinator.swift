//
//  AppCoordinator.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let firstViewController = BreweriesListViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: firstViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
