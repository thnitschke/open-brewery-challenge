//
//  BreweryViewModel.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation
import RxSwift

struct BreweryViewModel {
    private let brewery: Brewery
    
    var name: String {
        return brewery.name
    }
    var rating: String {
        return "\(brewery.mediumRate ?? 0)"
    }
    var displayAddress: String {
        return """
            \(brewery.street),
            \(brewery.city), \(brewery.state)
            \(brewery.country)
            """
    }
    
    init(brewery: Brewery) {
        self.brewery = brewery
    }
}
