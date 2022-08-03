//
//  ItemTextView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 6.06.2022.
//

import SwiftUI

struct ItemTextFieldView: View {
    // MARK: - Properties
    var title: String
    @Binding var value: String
    // MARK: - Body
    var body: some View {
        HStack {
            TextField(title, text: $value)
            
        }// End: -HStack
        .padding(.horizontal,15)
        .padding(.vertical,10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white))
        .padding(.vertical,5)
    }
    
}

struct ItemTextView_Previews: PreviewProvider {
    static var previews: some View {
        ItemTextFieldView(title: "Deneme", value: .constant("ali"))
    }
}
