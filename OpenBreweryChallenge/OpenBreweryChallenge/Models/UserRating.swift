//
//  UserRating.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation

struct UserRating: Codable {
    let breweryId: UInt
    let email: String
    let rate: UInt
}
