//
//  Users.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import Foundation

enum Users:String, Codable, CaseIterable{
    case Gizem
    case Emine
    case Musa
    case Omer
    case MFD
    case Pinar
    case Gulnur
    case Merve
    
    var emailAdress: String{
        switch self {
        case .Gizem:
            return ""
        case .Emine:
            return ""
        case .Musa:
            return ""
        case .Omer:
            return ""
        case .MFD:
            return "omikron44@hotmail.com"
        case .Pinar:
            return ""
        case .Gulnur:
            return ""
        case .Merve:
            return ""
        }
    }
}

