//
//  SharedPhotos.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI

struct NewSharedPhotos: View {
    @Binding var images:[UIImage]
    @Binding var addPressed: Bool
    @Binding var newImages: [UIImage]
    @State private var showPicker:Bool = false
    @State var totalImage: Int = 10
    var isUpdate:Bool
    
    var body: some View {
        GroupBox(content: {
            if images.count > 0{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        LazyHGrid(rows: [GridItem(.flexible(minimum: 200))], alignment: .center, spacing: 10, pinnedViews: [], content: {
                            ForEach(images,id:\.self){image in
                                GeometryReader { gr in
                                           Image(uiImage: image)
                                               .resizable()
                                               .scaledToFill()
                                               .frame(height: gr.size.width)
                                       }
                                       .clipped()
                                       .aspectRatio(1, contentMode: .fit)
                            }
                            ForEach(newImages,id:\.self){image in
                                GeometryReader { gr in
                                           Image(uiImage: image)
                                               .resizable()
                                               .scaledToFill()
                                               .frame(height: gr.size.width)
                                       }
                                       .clipped()
                                       .aspectRatio(1, contentMode: .fit)
                            }
                            
                        })
                        if images.count < 10{
                            AddButtonView(showPicker: $showPicker)
                        }
                    }
                }
            } else {
                AddButtonView(showPicker: $showPicker)
            }
        }, label: {
            GroupBoxLabelView(title: "Resimler", imageName: "photo.circle")
        })
        .padding(.horizontal)
        .fullScreenCover(isPresented: $showPicker) {
            ImagePicker(images: $images, newImages: $newImages, totalImage: $totalImage, isUpdate: isUpdate)
                .ignoresSafeArea(.keyboard)
        }.onChange(of: images) { newValue in
            totalImage = 10 - images.count
        }
        
    }
}
struct NewSharedPhotos_Previews: PreviewProvider {
    static var previews: some View {
        NewSharedPhotos(images: .constant([UIImage(named: "doga-2")!]),addPressed: .constant(false), newImages:.constant([UIImage(named: "doga-2")!]), isUpdate: false)
    }
}
