//
//  BaloonView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import SwiftUI

struct BaloonView: View {
    // MARK: - Properties
    @State private var isAnimate: Bool = false
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    // MARK: - Body
    var body: some View {
        VStack() {
           Image("remax")
                .imageModifier()
                .scaleEffect(isAnimate ? 1.0 : 0.5)
                .offset(x:isAnimate ? 0 : 150, y: isAnimate ? 0 : -150)
            Image("logo")
                .imageModifier()
                .scaleEffect(isAnimate ? 1.0 : 0.5)
            
        }// End: -VSTACK
        .padding(.horizontal)
        .offset(y:keyboardResponder.keybordAppear ? 70 : 0)
        .scaleEffect(keyboardResponder.keybordAppear ? 0.4 : 1)
        .animation(.easeInOut, value: keyboardResponder.keybordAppear)
        .frame( maxWidth:640)
        .onAppear {
            withAnimation(.easeIn(duration: 1.0)) {
                isAnimate = true
            }
        }
    }
}

struct BaloonView_Previews: PreviewProvider {
    static var previews: some View {
        BaloonView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
