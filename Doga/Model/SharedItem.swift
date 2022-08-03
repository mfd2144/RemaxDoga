//
//  SharedItem.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 27.06.2022.
//

import Foundation
import SwiftUI

struct SharedItem: Codable, Identifiable {
    var id: String
    var images: [String]
    let user: Users
    let propertyName: String
    let place: Places
    let estateType: RealEstateType
    let estateCondition: RealEstateCondition
    var landType: LandType?
    var coefficient: LandCoefficient?
    let price: String
    let urgency: Urgency
    let notes: String
    let createDate: TimeInterval
    let display: Int
    
    init(id: String = UUID().uuidString ,
         images: [String],
         user: Users,
         propertyName: String,
         place: Places,
         estateType: RealEstateType,
         estateCondition: RealEstateCondition,
         landType: LandType?,
         display: Int = 0,
         coefficient: LandCoefficient?,
         price: String,
         urgency: Urgency,
         notes: String,
         createDate: TimeInterval = Date().timeIntervalSince1970
    ){  self.id = id
        self.images = images
        self.user = user
        self.propertyName = propertyName
        self.place = place
        self.coefficient = coefficient
        self.estateType = estateType
        self.estateCondition = estateCondition
        self.landType = landType
        self.price = price
        self.urgency = urgency
        self.createDate = createDate
        self.notes = notes
        self.display = display
    }
}
extension SharedItem: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (rhs: SharedItem, lhs: SharedItem) -> Bool {
        return rhs.id == lhs.id
    }

}
