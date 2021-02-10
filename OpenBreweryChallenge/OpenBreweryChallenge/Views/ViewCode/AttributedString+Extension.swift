//
//  AttributedString+Extension.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 09/02/21.
//

import UIKit

extension NSMutableAttributedString {
    
    static func generateStarsText(for number: Int) -> NSMutableAttributedString {
        
        let starAttachment = NSTextAttachment()
        starAttachment.image = UIImage(systemName: "star")?.withTintColor(.systemOrange)
        let starFillAttachment = NSTextAttachment()
        starFillAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.systemOrange)
        
        let fullString = NSMutableAttributedString(string: "")
        for index in 1...5 {
            if index <= number {
                fullString.append(NSAttributedString(attachment: starFillAttachment))
            } else {
                fullString.append(NSAttributedString(attachment: starAttachment))
            }
        }
        
        return fullString
    }
}
