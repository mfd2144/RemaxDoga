//
//  AdSearchBar.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 2.06.2022.
//

import SwiftUI

struct AdSearchBar: View {
    // MARK: - Properties
    @Binding var adId: String
    @State private var isAnimated: Bool = false
    @State private var cancelButtonShown: Bool = false
    @State private var info: CustomAlertItem?
    // MARK: - Function
    private func clearTextField() {
        withAnimation(Animation.easeIn) {
            adId = ""
        }
    }
    private func searchFromDB() {
    }
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .trailing) {
            // TextBox
            TextField("İlan numarasından ara", text: $adId)
                .keyboardType(.numberPad)
                .padding(.horizontal)
                .padding(.vertical,10)
           Button(action: {
               clearTextField()
           }, label: {
               Text("Temizle")
                   .opacity(cancelButtonShown ? 1.0 : 0)
                   .offset(x: cancelButtonShown ? 0 : 20)
           })
           .padding(.trailing)
       
        }// End: - HStack
        .onChange(of: adId, perform: { _ in
            if !adId.isEmpty {
                CalledCommercialDataManager.share.fetchSearchedCommercials(id: adId, completion: { result in
                    switch  result{
                    case .error:
                        info = CustomAlertItem(id: .error, title: "Hata", message: "Lütfen internet bağlantınızı kontrol edin.")
                    default:
                        break
                    }
                    
                })
            }
            withAnimation(Animation.easeIn) {
                cancelButtonShown = adId.isEmpty ? false : true
            }
        })
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.white))
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray, lineWidth: 3))
        .alert(item: $info) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Tamam")))
        }
    }
}

struct AdSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        AdSearchBar(adId: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}



