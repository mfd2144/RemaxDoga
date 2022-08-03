//
//  SwiftUIView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 8.06.2022.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        Color.black.opacity(0.2)
            .ignoresSafeArea(.all, edges: .all)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
