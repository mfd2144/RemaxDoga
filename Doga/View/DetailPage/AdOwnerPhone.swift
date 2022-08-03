//
//  AdOwnerPhone.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 6.06.2022.
//

import SwiftUI

struct AdOwnerPhone: View {
    var phoneData: String
    var url:URL
    var body: some View {
            HStack(alignment: .center, spacing: 5) {
                Text("Telefon")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkBlue"))
                    .shadow(radius: 12)
                Spacer()
                Link(destination:url) {
                    Text(phoneData)
                        .font(.title3)
                        .lineLimit(1)

                    Image(systemName: "phone.circle")
                        .font(.system(size: 20, weight: .bold, design: .default))
                }
                .accentColor(Color("darkRed"))
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

struct AdOwnerPhone_Previews: PreviewProvider {
    static var previews: some View {
        AdOwnerPhone(phoneData: exampleData.first!.phoneNumber, url: URL(string: "\(exampleData.first!.phoneNumber)")!)
            .previewDevice("iPhone 12 Pro Max")
            .previewLayout(.sizeThatFits)
    }
}

