//
//  AdOwnerInformationView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 7.06.2022.
//

import SwiftUI

struct AdOwnerInformationView: View {
    @Binding var name: String
    @Binding var phoneNumber: String
    var body: some View {
        GroupBox (content: {
       ItemTextFieldView(title: "Adı Soyadı", value: $name)
            Divider()
            ItemTextFieldView(title: "Telefon", value: $phoneNumber)
                .keyboardType(.phonePad)
        }, label: {
            GroupBoxLabelView(title: "İlan Sahibi Bilgileri", imageName: "person.circle")
        })// End: -GroupBox
        .padding(.horizontal)
    }
}

struct AdOwnerInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AdOwnerInformationView(name: .constant(""), phoneNumber: .constant(""))
    }
}
