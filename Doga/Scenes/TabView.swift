//
//  TabView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 20.06.2022.
//

import SwiftUI

struct CustomTabView: View {
    // MARK: - Properties
    @EnvironmentObject var loginCondition: LogingCondition
    // MARK: - Functions
    private func tab1() -> some View{
        return CommercialsView()
            .tabItem {
                Image(systemName: "house")
                Text("İlanlar")
            }
    }
    private func tab2() -> some View{
        LogingPage()
            .environmentObject(LogingCondition())
            .tabItem {
                Image(systemName: "person")
                Text("Broker")
                
            }
    }
    private func tab3() -> some View{
        AboutPageView()
            .tabItem {
                Image(systemName: "questionmark.circle")
                Text("Hakkımızda")
                
            }
    }
    // MARK: - View
    var body: some View {
        TabView {
            tab1()
            tab2()
            tab3()
        }
        .accentColor(Color("lightBlue"))
    }
}

struct CustomTabView_Provider: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}


