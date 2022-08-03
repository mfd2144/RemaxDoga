//
//  SharedPhotos.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 8.07.2022.
//

import SwiftUI

struct SharedPhotos: View {
    var item: SharedItem
    @State var showImage: Bool = false
    @State var images: [UIImage?] = [UIImage(named: "doga")]
    @State var imageIndex:Int = 0
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 20, content:{
                LazyHGrid(rows: [GridItem(.flexible( maximum: 150))]) {
                    ForEach(Array(zip(images.indices, images)), id: \.0){ index, image in
                        Image(uiImage:image ?? UIImage(named: "doga")!)
                            .imageModifier()
                            .cornerRadius(10)
                            .onTapGesture {
                                imageIndex = index
                                showImage.toggle()
                            }
                    }
                }
            })
        }// End: -scrollview
        .frame(height: 200)
        .padding(.horizontal)
        .onAppear {
            StorageManager.shared.fetchAllImages(imagesRef: item.images) { result in
                switch result{
                case.success(let fetchedImages):
                    guard let fetchedImages = fetchedImages else {return}
                    images = fetchedImages
                default:
                    break
                }
            }
        }
        .fullScreenCover(isPresented: $showImage) {
            FullImageView(image: images[imageIndex]!, showImage: $showImage)
        }
    }
}

struct SharedPhotos_Previews: PreviewProvider {
    static var previews: some View {
        SharedPhotos(item: sharedItems.first!)
            .previewLayout(.sizeThatFits)
    }
}
