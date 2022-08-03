//
//  DetailHeader.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 4.06.2022.
//

import SwiftUI

struct DetailHeader: View {
    var user:Users
    
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(colors: [  Color("darkBlue"),Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: UIScreen.main.bounds.width-80, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x: 65)
        
            HStack (alignment: .center,spacing: 5) {
                    ZStack {
                        LinearGradient(colors: [  Color("darkRed"),Color("lightRed")], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(Color("lightRed"))
                            .clipShape(Circle())
                            .background(Circle().stroke(.white, lineWidth: 10))
                    
                        Text("DOĞA")
                            .font(.system(size: 26, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .shadow(radius: 12)
                    }
                    Spacer()
                    Text(user.rawValue)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .scaleEffect(1.3)
                        .foregroundColor(.white)
                        .shadow(radius: 12)
                        .offset(x: -50, y: 0)
                        .foregroundColor(.clear)
                    Spacer()
                // End: -ZStack
            }// End: -HStack
            .padding(.horizontal,15)
           
        }
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader(user: .MFD)
            .previewLayout(.sizeThatFits)
            .background(.gray)
    }
}
