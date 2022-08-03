//
//  DetailPageAnimationView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 5.06.2022.
//

import SwiftUI

struct DetailPageAnimationView: View {
    // MARK: - Properties
    // MARK: - Function
    private func randomScale() -> CGFloat {
        CGFloat.random(in: 0.4...1.0)
    }
    private func randomSize() -> CGFloat {
        CGFloat.random(in: 50...200)
    }
    private func randomCoordinate(max:CGFloat) -> CGFloat {
        return CGFloat.random(in: 0...max)
    }
    private func randomSpeed() -> Double {
        Double.random(in: 0.025...0.4)
    }
    //Random Delay
    private func randomDelay() -> Double {
        Double.random(in: 0...2.0)
    }
    @State private var isAnimation: Bool = false
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(1...10, id:\.self){ item in
                    Image("remax")
                        .imageModifier()
                        .frame(width: randomSize() , height: randomSize(), alignment: .center)
                        .scaleEffect(isAnimation ? randomScale() : 1)
                        .position(x: randomCoordinate(max: geometry.size.width),
                                   y: randomCoordinate(max: geometry.size.height))
                        .animation(Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
                            .repeatForever()
                            .speed(randomSpeed())
                            .delay(randomDelay()),
                                value: isAnimation)
                }
            }// End: -ZStack
            .onAppear {
                isAnimation = true
            }
            .drawingGroup()
        }// End: -Geometr
    }
}

struct DetailPageAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPageAnimationView()
    }
}
