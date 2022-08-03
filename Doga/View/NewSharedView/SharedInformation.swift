//
//  SharedInformation.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 1.07.2022.
//

import SwiftUI

struct SharedInformation: View {
    @Binding var title: String
    @Binding var price: String

    var body: some View {
        GroupBox(content: {
            ItemTextFieldView(title: "Başlık", value: $title)
            Divider()
                ItemTextFieldView(title: "Fiyat", value: $price)
                .keyboardType(.numbersAndPunctuation)
     
        }, label: {
            GroupBoxLabelView(title: "Genel Bilgiler", imageName: "info.circle")
        })
        .padding(.horizontal)
    }
}

struct SharedInformation_Previews: PreviewProvider {
    static var previews: some View {
        SharedInformation(title: .constant(""), price: .constant(""))
          
    }
}
