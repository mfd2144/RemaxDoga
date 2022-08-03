//
//  NewItemFooterView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 7.06.2022.
//

import SwiftUI

struct NewItemFooterView: View {
    @Binding var saveButtonPressed: Bool
    var buttonText: String
    var body: some View {
        Button(action: {
            saveButtonPressed.toggle()
        }, label: {
            HStack(alignment: .center, spacing: 10, content:{
                Spacer()
                Image(systemName: "folder.badge.plus")
                Text(buttonText)
                    .fontWeight(.medium)
                Spacer()
            })
            .font(.title3)
            .foregroundColor(.white)
            .frame(maxWidth: 640)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("green"))
                    
            )
        })
        .padding(.horizontal)
        .padding(.bottom,20)
    }
}

struct NewItemFooterView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemFooterView(saveButtonPressed: .constant(false), buttonText: "Bilgileri Kaydet")
            .padding()
            .previewLayout(.sizeThatFits)
            .background(.gray)
    }
}
