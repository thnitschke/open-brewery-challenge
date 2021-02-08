//
//  BreweriesService.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation
import RxSwift

protocol BreweriesServiceProtocol {
    func fetchBreweries() -> Observable<[Brewery]>
}

class BreweriesService: BreweriesServiceProtocol {
    
    func fetchBreweries() -> Observable<[Brewery]> {
        return Observable.create { observer -> Disposable in
            
//            // If API call
//            let task = URLSession.shared.dataTask(with: URL(string: "url-here")!) { data, _, _ in
//                guard let data = data else {
//                    observer.onError(
//                        NSError(domain: "", code: -1, userInfo: nil)
//                    )
//                    return
//                }
//
//                do {
//                    let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
//
//                    observer.onNext(restaurants)
//
//                } catch (let error) {
//                    observer.onError(error)
//                }
//            }
//            task.resume()
//
//            return Disposables.create {
//                task.cancel()
//            }
            
            guard let path = Bundle.main.path(forResource: "getBreweries", ofType: "json") else {
                observer.onError(
                    NSError(domain: "", code: -1, userInfo: nil)
                )
                return Disposables.create {}
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let restaurants = try JSONDecoder().decode([Brewery].self, from: data)
                
                observer.onNext(restaurants)
                
            } catch let error {
                observer.onError(error)
            }

            return Disposables.create {}
        }
    }
    
}
