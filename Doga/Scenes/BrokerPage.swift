//
//  BrokerPage.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 26.06.2022.
//

import SwiftUI

struct BrokerPage: View {
    // MARK: - Properties
    @State var commercialPageShown: Bool = false
    @State var sharedPageShown: Bool = false
    @EnvironmentObject var loginCondition: LogingCondition
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Text("Hoşgeldin \(loginCondition.user?.rawValue ?? "Broker")")
                .font(.title)
                .fontWeight(.bold)
            HStack(alignment: .center, spacing: 20, content: {
                Button(action: {
                    withAnimation {
                        commercialPageShown.toggle()
                    }
                }, label: {
                    VStack {
                        Image("sahibinden")
                            .imageModifier()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                        .shadow(radius: 12)
                        Text("Aranan İlanları")
                    }
                })
                Button(action: {
                    sharedPageShown.toggle()
                }, label: {
                    VStack {
                        Image("doga-2")
                            .imageModifier()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                        .shadow(radius: 12)
                        Text("Paylaşılanlar")
                    }
                })
            })// End: -Hstack
            .padding()
        }// End: -Vstack
        .fullScreenCover(isPresented: $commercialPageShown, content: {
            CalledCommercialPageView(isShown: $commercialPageShown)
        })
        .fullScreenCover(isPresented: $sharedPageShown, content: {
            SharedPage( isShown: $sharedPageShown)
        })
    }
}

struct BrokerPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        BrokerPage()
                .environmentObject(LogingCondition())
        }
    }
}
