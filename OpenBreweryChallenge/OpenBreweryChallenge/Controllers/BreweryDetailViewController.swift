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
    var ratingSelected: Int = 0
    private let service = BreweriesService()
    
    private let actionSheet = UIAlertController(title: "Rate brewery", message: "Please give the brewery a rating:", preferredStyle: .actionSheet)
    private let alertController = UIAlertController(title: "Email", message: "Please input your email:", preferredStyle: .alert)
    
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
        configureActionSheet()
        configureAlertController()
    }
    
    private func configureNavigationView() {
        navigationItem.title = viewModel?.name
        let filterSymbol = UIImage(systemName: "star.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterSymbol,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(sendRating))
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
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
    
    private func configureActionSheet() {
        
        for rating in 1...5 {
            let actionButton = UIAlertAction(
                title: "\(rating) star" + (rating > 1 ? "s" : ""),
                style: .default) { [unowned self] _ in
                self.ratingSelected = rating
                debugPrint("Rating selected: \(self.ratingSelected)")
                
                self.present(self.alertController, animated: true, completion: nil)
            }
            actionSheet.addAction(actionButton)
        }
    }
    
    private func configureAlertController() {
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [unowned self] _ in
            guard let textFields = self.alertController.textFields,
                  !textFields.isEmpty,
                  let viewModel = self.viewModel
                  else {
                // Could not find textfield
                return
            }
            
            let field = textFields[0]
            guard let email = field.text else { return }
            // store your data
            UserDefaults.standard.set(email, forKey: "userEmail")
            UserDefaults.standard.synchronize()
            
            self.service.sendRating(breweryId: viewModel.breweryId, value: viewModel.rating, email: email)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    }
    
    @objc private func sendRating() {
        UserDefaults.standard.string(forKey: "userEmail")
        
        self.present(self.actionSheet, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 2, section: 0) {
            guard let url = urlLabel.text else { return }
            
            coordinator?.presentWebview(urlString: url)
        }
    }
}
