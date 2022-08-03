//
//  ResultView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 5.06.2022.
//

import SwiftUI

struct ProgressView: View {
    var progress:Progress
    private var progressResult:String{
        switch progress {
        case .ongoing:
            return "Görüşme Devam Ediyor"
        case .negative:
            return "Kabul Etmedi"
        case .positive:
            return "İlanı Verecek"
        }
    }
    private var color:Color{
        switch progress {
        case .ongoing:
            return Color("yellow")
        case .negative:
            return Color("darkRed")
        case .positive:
            return Color("green")
        }
    }
    private var imageName: String{
        switch progress {
        case .ongoing:
            return "questionmark.circle"
        case .negative:
            return "xmark.circle"
        case .positive:
            return "checkmark.circle"
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
           
            Text(progressResult)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("darkBlue"))
                .shadow(radius: 12)
            Spacer()
            Image(systemName: imageName)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(color)

        }
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("lightBlue"), lineWidth: 3)
        )
        .padding(.horizontal,15)
    
    
}
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: .negative)
    }
}
