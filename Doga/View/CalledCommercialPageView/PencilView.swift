//
//  PencilView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 14.07.2022.
//

import SwiftUI

struct PencilView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.orange)
            Image(systemName: "pencil.circle")
                .foregroundColor(.white)
                .font(.largeTitle)
        }// End: -left ZStack
    }
}
