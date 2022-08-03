//
//  CustomError.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 12.07.2022.
//

import Foundation

enum CustomError: Error{
    case connectWithDeveloper
    case optionalError
    case emptyMetaData
    case fetchSharedItemsError
    case fetchCalledItemsError
    case dataParseError
    case dataEnumConvertError
    case itemAlreadyExist
}

