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
    
    let baseUrl = URL(string: "http://localhost:8080")
    
    func fetchBreweries() -> Observable<[Brewery]> {
        return Observable.create { [unowned self] observer -> Disposable in
            
            // API call
            let task = URLSession.shared.dataTask(with: URL(string: "/brewery/getBreweries", relativeTo: self.baseUrl)!) { data, _, _ in
                guard let data = data else {
                    observer.onError(
                        NSError(domain: "", code: -1, userInfo: nil)
                    )
                    return
                }
                
                do {
                    let breweries = try JSONDecoder().decode([Brewery].self, from: data)
                    
                    observer.onNext(breweries)
                    
                } catch let error {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
            //            guard let path = Bundle.main.path(forResource: "getBreweries", ofType: "json") else {
            //                observer.onError(
            //                    NSError(domain: "", code: -1, userInfo: nil)
            //                )
            //                return Disposables.create {}
            //            }
            //
            //            do {
            //                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            //                let breweries = try JSONDecoder().decode([Brewery].self, from: data)
            //
            //                observer.onNext(breweries)
            //
            //            } catch let error {
            //                observer.onError(error)
            //            }
            //
            //            return Disposables.create {}
        }
    }
    
    func sendRating(breweryId: Int, value: Int, email: String) -> Observable<String> {
        return Observable.create { [unowned self] observer -> Disposable in
            
            var request = URLRequest(url: URL(string: "/breweryRate", relativeTo: self.baseUrl)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let data = UserRating(breweryId: breweryId, email: email, rate: value)
            do {
                let jsonData = try JSONEncoder().encode(data)
                request.httpBody = jsonData
            } catch let error {
                observer.onError(error)
            }
            
            // API call
            let task = URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let data = data else {
                    observer.onError(
                        NSError(domain: "", code: -1, userInfo: nil)
                    )
                    return
                }
                if let json = String(data: data, encoding: .utf8) {
                    observer.onNext(json)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
