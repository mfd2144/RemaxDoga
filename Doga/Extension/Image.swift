//
//  Image.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 27.06.2022.
//

import SwiftUI


extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    func placeHolderModifier() -> some View {
        self
            .imageModifier()
            .foregroundColor(.red)
            .frame(maxWidth:140)
            .opacity(0.5)
    }
}
