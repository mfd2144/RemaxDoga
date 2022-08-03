//
//  NotesView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 6.06.2022.
//

import SwiftUI

struct NotesView: View {
    var noteString:String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Notlar")
                .foregroundColor(Color("darkRed"))
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .shadow(radius: 12)
            HStack(alignment: .center) {
                Text(noteString)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                .font(.body)
                Spacer()
            }// End: -HStack
        }// End: -VStack
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("lightBlue"), lineWidth: 3)
        )
    .padding(.horizontal,15)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(noteString: "Siz de kendi güvenliğiniz ve diğer kullanıcıların daha sağlıklı alışveriş yapabilmeleri için, satın almak istediğiniz ürünü teslim almadan ön ödeme yapmamaya, avans ya da kapora ödememeye özen gösteriniz. İlan sahiplerinin ilanlarda belirttiği herhangi bir bilgi ya da görselin gerçeği yansıtmadığını düşünüyorsanız veya ilan sahiplerinin hesap profillerindeki bilgilerin doğru olmadığını düşünüyorsanız, lütfen bize haber veriniz.")
            .previewLayout(.sizeThatFits)
    }
}
