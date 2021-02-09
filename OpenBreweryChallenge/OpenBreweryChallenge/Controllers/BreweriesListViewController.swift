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
        let filterSymbol = UIImage(systemName: "line.horizontal.3.decrease.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterSymbol,
                                                            style: .done,
                                                            target: nil,
                                                            action: nil)
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = .all
        
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
                    customView.tableView.rx.items(cellIdentifier: "cell", cellType: BreweryCardView.self)) { index, viewModel, cell in
                cell.mainText = viewModel.name
            }.disposed(by: disposeBag)
    }

}
