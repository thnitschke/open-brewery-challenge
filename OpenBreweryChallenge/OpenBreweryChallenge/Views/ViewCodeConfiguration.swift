//
//  ViewCodeConfiguration.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    
    func configureView() {}
    
    func render() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
