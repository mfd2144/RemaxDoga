//
//  File.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 25.07.2022.
//

import Foundation

struct CustomAlertItem: Identifiable{
    enum AlertType{
        case emptyBox
        case success
        case error
        case info
        case caution
    }
    let id:AlertType
    let title:String
    let message:String
}
