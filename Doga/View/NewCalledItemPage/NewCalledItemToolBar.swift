//
//  NewCalledItemToolBar.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 17.07.2022.
//

import SwiftUI

struct NewCalledItemToolBar: View {
    var updatePage: Bool
    @Binding var showNewItem: Bool
    @Binding var buttonPressed: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button(action: {
                withAnimation {
                    showNewItem.toggle()
                }
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            })// End: -CloseButton
            Button(action: {
                buttonPressed.toggle()
            }, label: {
                VStack {
                    Text(updatePage ? "Güncelle" : "Kaydet")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
            })// End: -SaveButton
        }// End: -HStack
        .accentColor(Color("darkBlue"))
    }
}

struct NewCalledItemToolBar_Previews: PreviewProvider {
    static var previews: some View {
        NewCalledItemToolBar(updatePage: false, showNewItem: .constant(false), buttonPressed: .constant(false))
    }
}
