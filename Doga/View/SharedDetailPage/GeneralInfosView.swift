//
//  UserView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI

struct GeneralInfosView: View {
    var item: SharedItem
    var body: some View {
        GroupBox(content: {
            GroupBoxComponentView(title: "Broker", value: item.user.rawValue)
            GroupBoxComponentView(title: "Aciliyet", value: item.urgency.rawValue)
        }, label: {
            GroupBoxLabelView(title: "Genel Bilgiler", imageName: "info.circle")
        })
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct GeneralInfosView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInfosView(item: sharedItems.first!)
    }
}
