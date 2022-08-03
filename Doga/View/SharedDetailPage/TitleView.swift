//
//  Title.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI

struct TitleView: View {
    // MARK: - Properties
    var item:SharedItem
    // MARK: - Body
    var body: some View {
        GroupBox{
            HStack{
                Spacer()
                Text(item.propertyName)
                    .fontWeight(.bold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .layoutPriority(1)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(item: sharedItems.first!)
            .previewLayout(.sizeThatFits)
    }
}
