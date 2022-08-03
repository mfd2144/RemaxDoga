//
//  HideKeyboard.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeybord() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
