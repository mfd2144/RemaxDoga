//
//  SwipeItems.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 9.06.2022.
//

import SwiftUI



struct SlideItem<Left: View, Content: View, Right: View>: View {
    var content: () -> Content
    var left: () -> Left
    var right: () -> Right
    var itemHeight: CGFloat
    var id: String
    
    @State var hoffset: CGFloat = 0
    @State var anchor: CGFloat = 0
    
    let screenWidth = UIScreen.main.bounds.width
    var anchorWidth: CGFloat { screenWidth / 3 }
    var slideThreshold: CGFloat { screenWidth / 15 }
    
    @State var rightPast = false
    @State var leftPast = false
    @ObservedObject var slideManager = SlideManager.shared
    
    init(@ViewBuilder content: @escaping () -> Content,
         @ViewBuilder left: @escaping () -> Left,
         @ViewBuilder right: @escaping () -> Right,
         itemHeight: CGFloat,
         id: String) {
        self.content = content
        self.left = left
        self.right = right
        self.itemHeight = itemHeight
        self.id = id
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    hoffset = anchor + value.translation.width
                    
                    if abs(hoffset) > anchorWidth {
                        if leftPast {
                            hoffset = anchorWidth
                        } else if rightPast {
                            hoffset = -anchorWidth
                        }
                    }
                    if anchor > 0 {
                        leftPast = hoffset > anchorWidth - slideThreshold
                    } else {
                        leftPast = hoffset > slideThreshold
                    }
                    
                    if anchor < 0 {
                        rightPast = hoffset < -anchorWidth + slideThreshold
                    } else {
                        rightPast = hoffset < -slideThreshold
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if rightPast {
                        anchor = -anchorWidth
                        slideManager.slideItemId = id
                    } else if leftPast {
                        anchor = anchorWidth
                        slideManager.slideItemId = id
                    } else {
                        anchor = 0
                    }
                    hoffset = anchor
                }
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                left()
                    .frame(width: anchorWidth)
                    .zIndex(1)
                    .clipped()
                
                content()
                    .frame(width: geo.size.width)
                    .zIndex(0)
                
                
                right()
                    .frame(width: anchorWidth)
                    .zIndex(1)
                    .clipped()
            }
            .onChange(of: slideManager.slideItemId) { newValue in
                if slideManager.slideItemId != id{
                    withAnimation {
                        anchor = 0
                        hoffset = 0
                    }
                }
            }
        }
        .offset(x: -anchorWidth + hoffset)
        .frame(height: itemHeight)
        .contentShape(Rectangle())
        .gesture(drag)
        .clipped()
    }
}

