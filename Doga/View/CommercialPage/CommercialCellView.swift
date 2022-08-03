//
//  CommercialCellView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 20.06.2022.
//

import SwiftUI

struct CommercialCellView: View {
    var data: WebCommercial
    var body: some View {
        VStack {
            Text(data.itemTitle)
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .bold, design: .default))
            HStack(alignment: .center, spacing: 5) {
                WebImageView(imageUrlString: data.thumbnail)
                    .clipShape(RoundedRectangle(cornerRadius: 10)
                    )
                Spacer()
                VStack(alignment: .trailing, spacing: 20){
                    Text(data.itemDetail)
                    Text(data.price)
                }// End: -Vstack
                .font(.title3)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .frame( height: 100)
                Text(data.place)
                .font(.system(size: 14, weight: .bold, design: .default))
        }// End: -Vstack
        .padding(.vertical)
    }
}

struct CommercialCellView_Previews: PreviewProvider {
    static var previews: some View {
        CommercialCellView(data: commercials.first!)
    }
}

