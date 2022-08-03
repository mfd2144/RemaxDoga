//
//  String.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 7.06.2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func makeTurkish() -> String?{
        if let data = self.data(using: .utf16), let attributedString = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            let finalString = attributedString.string
            return finalString
        } else {
            return nil
        }
    }
}

func changeString(value: String?) -> String? {
    guard let string = value?
        .replacingOccurrences(of: "_", with: " ")
        .lowercased()
        .capitalizingFirstLetter()
    else {return nil}
    return string
}
