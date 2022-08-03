//
//  loging.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import SwiftUI

struct LogingPage: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var loginCondition: LogingCondition
    @State private var showVerificationCaution: Bool = false
    @State private var showContactWithSuperviser: Bool = false
    //MARK: -FUNCTION
    var body: some View {
        ZStack {
            if !loginCondition.isLoging{
                VStack(alignment: .center) {
                    BaloonView()
                    BottomView(showVerificationCaution: $showVerificationCaution, showContactWithSuperviser: $showContactWithSuperviser)
                }.alert("Uyarı", isPresented: $showVerificationCaution, actions: {}, message: {
                    Text("Lütfen mailin kutunuzu kontrol edin ve gelen mesajdaki doğrulama linkine tıklayın ")
                })
                    .alert("Uyarı", isPresented: $showContactWithSuperviser, actions: {}, message: {
                        Text("Lütfen program yöneticisiyle temas kurun")
    
                    })
            } else {
                BrokerPage()
            }
        }
    }
}


struct Loging_Previews: PreviewProvider {
    static var previews: some View {
        LogingPage().padding()
            .environmentObject(LogingCondition())
            .previewDevice("iPhone 13 Pro Max")
    }
}
