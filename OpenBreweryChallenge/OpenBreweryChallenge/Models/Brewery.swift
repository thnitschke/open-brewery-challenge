//
//  Brewery.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation

struct Brewery: Decodable {
    let id: UInt
    let name: String
    let breweryType: String
    let street: String
    let city: String
    let state: String
    let country: String
    let longitude: String
    let latitude: String
    let websiteUrl: String
    let mediumRate: Double?
}

enum BreweryType: String, Decodable {
    case micro
    case nano
    case regional
    case brewpub
    case large
    case planning
    case bar
    case contract
    case proprietor
    case closed
}
