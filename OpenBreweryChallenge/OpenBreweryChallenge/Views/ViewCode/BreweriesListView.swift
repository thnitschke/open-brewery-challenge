//
//  BreweriesListView.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import UIKit

class BreweriesListView: UIView, ViewCodeConfiguration {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    func buildHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureViews() {
        backgroundColor = .systemGroupedBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}
