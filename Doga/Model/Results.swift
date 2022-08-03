//
//  Result.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 4.07.2022.
//

import Foundation

enum Results<Value>{
    case success(Value?)
    case error(Error)
}
