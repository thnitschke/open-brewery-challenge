//
//  ViewController.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 05/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class BreweriesListViewController: UIViewController, HasCustomView {
    
    let disposeBag = DisposeBag()
    private var viewModel: BreweriesListViewModel!
    
    typealias CustomView = BreweriesListView
    
    override func loadView() {
        let customView = CustomView(frame: .zero)
        view = customView
        
        navigationItem.title = "Breweries"
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        customView.render()
    }
    
    static func instantiate(viewModel: BreweriesListViewModel = BreweriesListViewModel()) -> BreweriesListViewController {
        let viewController = BreweriesListViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchBreweriesViewModels()
        .observe(on: MainScheduler.instance)
            .bind(to:
                    customView.tableView.rx.items(cellIdentifier: "cell")) { index, viewModel, cell in
                cell.textLabel?.text = viewModel.name
            }.disposed(by: disposeBag)
    }

}
