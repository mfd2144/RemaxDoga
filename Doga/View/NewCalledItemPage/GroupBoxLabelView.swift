//
//  GroupBoxLabelView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 7.06.2022.
//

import SwiftUI

struct GroupBoxLabelView: View {
    var title: String
    var imageName: String
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.title3)
            Spacer()
            Image(systemName:imageName )
                .foregroundColor(Color("darkRed"))
                .font(.system(size: 26, weight: .medium, design: .default))
        }
        .foregroundColor(Color("darkBlue"))
    }
}

struct GroupBoxLabelView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBoxLabelView(title: "İlan Sahibi Bilgileri", imageName: "person.circle")
    }
}
