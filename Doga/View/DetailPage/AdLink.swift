//
//  AdLink.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 5.06.2022.
//

import SwiftUI

struct AdLink: View {
    var adData:CalledCommercial
    var url:URL {
        URL(string:adData.adLink)!
    }
    var body: some View {
            HStack(alignment: .center, spacing: 5) {
                Text("Sahibinden")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkBlue"))
                    .shadow(radius: 12)
                Spacer()
                Link(destination:url) {
                    Text(adData.id)
                        .font(.title3)
                        .lineLimit(1)
                      
                    Image(systemName: "chevron.right.square")
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

struct AdLink_Previews: PreviewProvider {
    static var previews: some View {
        AdLink(adData: exampleData.first!)
            .previewDevice("iPhone 12 Pro Max")
            .previewLayout(.sizeThatFits)
    }
}
