//
//  OtherDetails.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 5.06.2022.
//

import SwiftUI

struct OtherDetails: View {
    var title: String
    var data: String
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("darkBlue"))
                .shadow(radius: 12)
            Spacer()
            Text(data)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(Color("darkRed"))
                .shadow(radius: 12)
        }
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("lightBlue"), lineWidth: 3)
        )
        .padding(.horizontal,15)
        
    }
}

struct OtherDetails_Previews: PreviewProvider {
    static var previews: some View {
        OtherDetails(title: "Telefon", data: "05313907334")
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.gray)
    }
}
