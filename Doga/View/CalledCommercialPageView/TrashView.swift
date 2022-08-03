//
//  TrashView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 14.07.2022.
//

import SwiftUI

struct TrashView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.red)
            Image(systemName: "trash.circle")
                .foregroundColor(.white)
                .font(.largeTitle)
        }// End: -right Zstack
    }
}

struct TrashView_Previews: PreviewProvider {
    static var previews: some View {
        TrashView()
    }
}
