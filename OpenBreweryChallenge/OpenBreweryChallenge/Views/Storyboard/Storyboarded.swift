//
//  Storyboarded.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 09/02/21.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "BreweryDetail", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self
        else { fatalError("View Controller should have been created by storyboard") }
        return viewController
    }
}
