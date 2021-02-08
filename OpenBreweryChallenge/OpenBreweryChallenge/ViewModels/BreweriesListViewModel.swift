//
//  BreweriesListViewModel.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation
import RxSwift

final class BreweriesListViewModel {
    let title = "Breweries"
    
    private let breweriesService: BreweriesServiceProtocol
    
    init(breweriesService: BreweriesServiceProtocol = BreweriesService()) {
        self.breweriesService = breweriesService
    }
    
    func fetchBreweriesViewModels() -> Observable<[BreweryViewModel]> {
        breweriesService.fetchBreweries().map { $0.map {
            BreweryViewModel(brewery: $0)} }
    }
}
