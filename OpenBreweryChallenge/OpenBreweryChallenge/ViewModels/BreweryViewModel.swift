//
//  BreweryViewModel.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation
import RxSwift
import SwifterSwift

struct BreweryViewModel {
    private let brewery: Brewery
    
    var name: String {
        return brewery.name
    }
    var type: String {
        return brewery.breweryType
    }
    var rating: Int {
        return brewery.mediumRate?.int ?? 0
    }
    var url: String {
        return brewery.websiteUrl
    }
    var displayAddress: String {
        return """
            \(brewery.street),
            \(brewery.city), \(brewery.state)
            \(brewery.country)
            """
    }
    var latitude: String {
        return brewery.latitude
    }
    var longitude: String {
        return brewery.longitude
    }
    
    init(brewery: Brewery) {
        self.brewery = brewery
    }
}
