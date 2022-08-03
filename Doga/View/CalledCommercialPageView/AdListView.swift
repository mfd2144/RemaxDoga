//
//  AdListView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 2.06.2022.
//

import SwiftUI

struct AdListView: View {
    // MARK: - Properties
    var adData: CalledCommercial
    var typeTitle: String{
        if adData.type == .land{
            return "\(adData.type.rawValue) \(adData.landType!.rawValue)"
        } else {
            return "\(adData.type.rawValue)"
        }
    }
    @EnvironmentObject var loginCondition: LogingCondition
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            Capsule().fill(Color(adData.progress.colorName))
                .frame(width:8,height:50 )
            VStack(alignment: .leading, spacing: 5){
                Text(adData.id)
                    .fontWeight(.heavy)
                    .font(.title3)
                    .foregroundColor(.black)
                Text("\(adData.user.rawValue)")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }// End: -VStack
            Spacer()
            Text(typeTitle)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.gray)
        }// End: -HStack
        .padding(.horizontal)
    }
}

struct AdListView_Previews: PreviewProvider {
    static var previews: some View {
        AdListView(adData: exampleData.first!)
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(LogingCondition())
    }
}
