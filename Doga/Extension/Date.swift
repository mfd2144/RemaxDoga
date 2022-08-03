//
//  Date.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 6.06.2022.
//

import Foundation

extension Date {
    func converToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        dateFormatter.locale = Locale(identifier: "tr")
        return dateFormatter.string(from: self)
    }
    
    func dateDifference() -> String? {
        let calender = Calendar.current
        let now = Date()
        guard let difference = calender.dateComponents([.day], from: now, to: self).day else {return nil}
        return "\(difference) day"
    }
}
