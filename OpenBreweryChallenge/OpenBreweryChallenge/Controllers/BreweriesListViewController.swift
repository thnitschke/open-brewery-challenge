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
    
    weak var coordinator: AppCoordinator?
    
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
                    customView.tableView.rx.items(cellIdentifier: "cell", cellType: BreweryCardView.self)) { _, viewModel, cell in
                cell.mainText = viewModel.name
                cell.rating = viewModel.rating
            }.disposed(by: disposeBag)
        
        customView.tableView.rx.modelSelected(BreweryViewModel.self).subscribe(onNext: { [unowned self] item in
            self.coordinator?.getDetail(for: item)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customView.tableView.dataSource = nil
        viewModel.fetchBreweriesViewModels()
            .observe(on: MainScheduler.instance)
            .bind(to:
                    customView.tableView.rx.items(cellIdentifier: "cell", cellType: BreweryCardView.self)) { _, viewModel, cell in
                cell.mainText = viewModel.name
                cell.rating = viewModel.rating
            }.disposed(by: disposeBag)
    }

}
