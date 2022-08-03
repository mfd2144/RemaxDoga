//
//  GroupBpxComponentView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI

struct GroupBoxComponentView: View {
    var title: String
    var value: String
    var body: some View {
        VStack{
            Divider()
            HStack{
                Text(title)
                Spacer()
                Text(value)
            }
        }
    }
}

struct GroupBoxComponentView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBoxComponentView(title: "one", value: "value")
    }
}
