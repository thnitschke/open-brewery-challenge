//
//  AppCoordinator.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import UIKit
import SafariServices

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController = BreweriesListViewController.instantiate()
        firstViewController.coordinator = self
        navigationController.pushViewController(firstViewController, animated: false)
    }
    
    func getDetail(for brewery: BreweryViewModel) {
        let detailViewController = BreweryDetailViewController.instantiate()
        detailViewController.coordinator = self
        detailViewController.viewModel = brewery
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func presentWebview(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let webviewController = SFSafariViewController(url: url)
        webviewController.modalPresentationStyle = .pageSheet
        navigationController.present(webviewController, animated: true)
    }
}
