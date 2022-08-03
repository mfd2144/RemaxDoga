//
//  WebCommercial.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 20.06.2022.
//

import Foundation

struct WebCommercial {
    let itemTitle: String
    let itemDetail: String
    let price: String
    let link: String
    let thumbnail: String
    let place: String
    var itemLink: String{
        return "https://www.remax.com.tr"+link
    }
}
