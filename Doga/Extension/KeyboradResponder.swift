//
//  KeyboradManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 3.06.2022.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
@Published var currentHeight: CGFloat = 0
@Published var keyboardDuration: TimeInterval = 0
@Published var keybordAppear: Bool = false
private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()

init() {
    let publisher1 = NotificationCenter.Publisher(center: .default, name: UIResponder.keyboardWillShowNotification).map{ [weak self] notification -> Just<(CGFloat, TimeInterval)> in
        guard let self = self else {return Just((CGFloat(0.0), 0.0))}
    guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return Just((CGFloat(0.0), 0.0)) }
    guard let duration:TimeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return Just((CGFloat(0.0), 0.0)) }
        self.keybordAppear = true
    return Just((keyboardSize.height, duration))}

    let publisher2 = NotificationCenter.Publisher(center: .default, name: UIResponder.keyboardWillHideNotification) .map{ [weak self] notification -> Just<(CGFloat, TimeInterval)> in
        guard let self = self else {return Just((CGFloat(0.0), 0.0))}
           guard let duration:TimeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return Just((CGFloat(0.0), 0.0)) }
        self.keybordAppear = false
               return Just((0.0, duration))}

    Publishers.Merge(publisher1, publisher2).switchToLatest().subscribe(on: RunLoop.main).sink(receiveValue: { [weak self] in
        guard let self = self else {return}
            if $0.1 > 1e-6 {self.currentHeight = $0.0}
        self.keyboardDuration = $0.1
        }).store(in: &anyCancellable)
}
}

