//
//  LogingCondition.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import Foundation

class LogingCondition: ObservableObject {
    @Published var isLoging: Bool = false
    @Published var user: Users?
}
