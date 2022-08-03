//
//  AdInformationView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 7.06.2022.
//

import SwiftUI

struct AdInformationView: View {
    @Binding var adID: String
    @Binding var adLink: String
    var lock: Bool
    var body: some View {
        GroupBox (content: {
       ItemTextFieldView(title: "İlan Numarası", value: $adID)
                .keyboardType(.phonePad)
                .disabled(lock)
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black.opacity(lock ? 0.2 : 0.0))
                            .padding(.vertical,5)
                    
                )
            Divider()
            ItemTextFieldView(title: "İlan Linki", value: $adLink)
        }, label: {
            GroupBoxLabelView(title: "İlan Bilgileri", imageName: "info.circle")
        })// End: -GroupBox
        .padding(.horizontal)
    }
}

struct AdInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AdInformationView(adID: .constant(""), adLink: .constant(""), lock: true)
    }
}
