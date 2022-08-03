//
//  SwipeManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 9.06.2022.
//

import Foundation
import SwiftUI

class SlideManager: ObservableObject {
    static let shared = SlideManager()
    private init(){ }
    @Published var slideItemId:String = ""
}
