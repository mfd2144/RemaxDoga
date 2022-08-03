//
//  File.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 2.06.2022.
//

import Foundation

class CalledCommercial: Codable,Identifiable, Equatable{
    static func == (lhs: CalledCommercial, rhs: CalledCommercial) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    var adOwner: String
    var phoneNumber: String
    var adLink: String = "https://remaxdoga.sahibinden.com"
    var date: TimeInterval?//for remembering call time
    let adDate: TimeInterval
    var places: Places
    var progress: Progress
    let user: Users
    var notes: String?
    let type: RealEstateType
    var condition: RealEstateCondition
    var landType:LandType?
    var landCoefficient: LandCoefficient?
    
    init(id: String,
         adOwner: String,
         phoneNumber: String,
         adLink: String?,
         date: TimeInterval?,
         places: Places,
         adDate: TimeInterval = Date().timeIntervalSince1970,
         progress: Progress,
         user:Users,
         notes: String?,
         type: RealEstateType,
         condition: RealEstateCondition,
         landType:LandType?,
         landCoefficient: LandCoefficient?
    ) {
        self.id = id
        self.adOwner = adOwner
        if let adlink = adLink{
            self.adLink = adlink
        }
        self.phoneNumber = phoneNumber
        self.date = date
        self.adDate = adDate
        self.places = places
        self.progress = progress
        self.user = user
        self.notes = notes
        self.type = type
        self.condition = condition
        self.landType = landType
        self.landCoefficient = landCoefficient
    }
    
    
}

enum Progress:String, Codable, CaseIterable{
    case ongoing = "Görüşülüyor"
    case negative = "Olumsuz"
    case positive = "Olumlu"
    
    var colorName: String{
        switch self {
        case .ongoing:
            return "yellow"
        case .negative:
            return "darkRed"
        case .positive:
            return "green"
        }
    }
}

enum RealEstateType: String, Codable,CaseIterable, Identifiable{
    case land = "Arsa"
    case villa = "Villa"
    case apartment = "Apartman"
    case flat = "Daire"
    //computed property to get name, which is just the case's rawValue
    var name: String { self.rawValue }
    //Identifiable so we can use in ForEach
    var id: String { self.rawValue }
}

enum RealEstateCondition:String, Codable, CaseIterable, Identifiable {
    case forSale = "Satılık"
    case forRent = "Kiralık"
    case seasonal = "Sezonluk"
    //computed property to get name, which is just the case's rawValue
    var name: String { self.rawValue }
    //Identifiable so we can use in ForEach
    var id: String { self.rawValue }
}

enum LandType: String, Codable, CaseIterable, Identifiable {
    case empty = "Bilinmiyor"
    case agriculture = "Tarım"
    case construction = "Konut"
    case commercial = "Ticari"
    case constructionPlusCommercial = "Konut+Ticari"
    case tt1 = "TT-1"
    case tt2 = "Günübirlik"
    case tt3 = "TT-3"
    case tt4 = "Eko Turizm"
    //computed property to get name, which is just the case's rawValue
    var name: String { self.rawValue }
    //Identifiable so we can use in ForEach
    var id: String { self.rawValue }
}

enum LandCoefficient: String, Codable, CaseIterable, Identifiable{
    case zero = "Yok"
    case five = "0,05"
    case ten = "0,10"
    case fifteen = "0,15"
    case twenty = "0,2"
    case twentyFive = "0,25"
    case thirty = "0,30"
    case thirtyFive = "0,35"
    case forthy = "0,40"
    case forthyFive = "0,45"
    case fifthy = "0,50"
    case fifthyFive = "0,55"
    case sixty = "0,6"
    case sixtyFive = "0,65"
    case more = "0,65 den büyük"
    var id: String { self.rawValue }
    var name: String{ self.rawValue }
}
