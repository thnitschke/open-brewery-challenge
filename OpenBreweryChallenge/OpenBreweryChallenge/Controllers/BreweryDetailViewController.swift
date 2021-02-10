//
//  BreweryDetailViewController.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 09/02/21.
//

import UIKit

class BreweryDetailViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: AppCoordinator?
    var viewModel: BreweryViewModel?
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationView()
        configureBreweryInformation()
    }
    
    private func configureNavigationView() {
        navigationItem.title = viewModel?.name
        let filterSymbol = UIImage(systemName: "star.circle")
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
    }
    
    private func configureBreweryInformation() {
        guard let brewery = viewModel else { return }
        
        typeLabel.text = brewery.type
        ratingLabel.attributedText = NSMutableAttributedString.generateStarsText(for: brewery.rating)
        urlLabel.text = brewery.url
        addressLabel.text = brewery.displayAddress
        latitudeLabel.text = brewery.latitude
        longitudeLabel.text = brewery.longitude
    }
}
