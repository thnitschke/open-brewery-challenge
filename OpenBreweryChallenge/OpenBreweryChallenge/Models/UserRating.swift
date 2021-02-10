//
//  UserRating.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 08/02/21.
//

import Foundation

struct UserRating: Encodable {
    let breweryId: Int
    let email: String
    let rate: Int
}
