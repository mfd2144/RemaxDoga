//
//  ImageView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 13.07.2022.
//

import SwiftUI

struct FullImageView: View {
    let image:UIImage
    @Binding var showImage:Bool
    var body: some View {
        Image(uiImage: image)
            .imageModifier()
            .onTapGesture {
                showImage.toggle()
            }
    }
}

struct FullImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullImageView(image: UIImage(named: "doga")!, showImage: .constant(false))
    }
}
