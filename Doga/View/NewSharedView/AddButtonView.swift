//
//  AddButtonView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 1.07.2022.
//

import SwiftUI

struct AddButtonView: View {
    @Binding var showPicker: Bool
    var body: some View {
        HStack{
            Button(action: {
                showPicker.toggle()
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .frame(width: 200 , height: 200, alignment: .center)
                        .background()
                    Image(systemName: "plus")
                        .imageModifier()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding()
                }
                
            })
            Spacer()
        }

    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(showPicker: .constant(false))
    }
}
