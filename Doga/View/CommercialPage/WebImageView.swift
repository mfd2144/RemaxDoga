//
//  WebImageView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 20.06.2022.
//

import SwiftUI

struct WebImageView: View {
    var imageUrlString:String
    var body: some View {
        AsyncImage(url: URL(string: imageUrlString),transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))){ phase in
            switch phase{
            case.empty:
                Image(systemName: "photo.circle.fill").imageModifier()
            case.failure:
                Image(systemName: "ant.circle.fill").placeHolderModifier()
            case.success(let image):
                image.imageModifier()
            @unknown default:
                Image(systemName: "ant.circle.fill").placeHolderModifier()
            }
        }
        .frame(width: 150)
    }
}

struct WebImageView_Previews: PreviewProvider {
    static var previews: some View {
        WebImageView(imageUrlString: commercials.first!.thumbnail)
    }
}
