//
//  AboutPageView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 24.07.2022.
//

import SwiftUI

struct AboutPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("onboardView")  private var isOnboardActive: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                 //MARK: - SECTION 1
                    GroupBox {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10) {
                            Text("RE/MAX DOĞA (MAN Gayrinenkul LTD ŞTİ & M11 Proje Yönetim ve Danışmanlık Anonim Şirketi) 20 Yıllık Mesleki ve 10 Yıllık Kamu Tecrübesiyle; Gayrimenkul Yatırım Danışmanlığı, Yapısal Proje Geliştirilmesi, Proje Alanı Geliştirilmesi, Gayrimenkul Geliştirilmesi, İmar Mevzuatı, Planlama Mevzuatı, Gayrimenkul Mevzuatı, Mülkiyet Problemleri, Gayrimenkul Değerleme Hizmetlerinin tamamını Kurumsal ve Güvenilir bir şekilde sunmaktadır.")
                                .font(.footnote)
                        }
                    } label: {
                        HStack{
                            HStack{
                                Text("REMAX")
                                    .foregroundColor(Color("lightRed"))
                                    .fontWeight(.bold)
                                Text("DOĞA")
                                    .foregroundColor(Color("darkBlue"))
                                    .fontWeight(.bold)
                            }
                            .font(.system(.title3, design: .default))
                            
                            Spacer()
                            Image("doga-2")
                                .imageModifier()
                                .frame(height: 35)
                        }
                    }

                    //MARK: - SECTION 2
                    
                    GroupBox {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10){
                            Text("Uygulamada bulunan ilanların bilgileri www.remax.com.tr/doga sayfasından çekilmektedir. Diğer ilanlarımıza  https://remaxdoga.sahibinden.com  adresinden ulaşabilirsiniz.")
                                .font(.footnote)
                        }
                        
                    
                      } label: {
                          GroupBoxLabelView(title: "BİLGİLENDİRME", imageName: "info.circle")
                    }

                    //MARK: - SECTION 3
                    GroupBox(
                      label:
                      GroupBoxLabelView(title: "UYGULAMA", imageName: "apps.iphone")
                    ) {
                      SettingsRowView(name: "Developer", content: "M.Fatih DOĞAN")
                      SettingsRowView(name: "Designer", content: "M.Fatih DOĞAN")
                      SettingsRowView(name: "Compatibility", content: "iOS 15+")
                      SettingsRowView(name: "Twitter", linkLabel: "@IOSDeveloper84", linkDestination: "twitter.com/IOSDeveloper84")
                      SettingsRowView(name: "SwiftUI", content: "2.0")
                      SettingsRowView(name: "Version", content: "1.0")
                    }
                    
              
                }// :VSTACK
                .padding()
            }// :SCROLLVIEW
            .navigationTitle("Hakkımızda")
            .navigationBarTitleDisplayMode(.large)
            
        }// :NAVIGATIONVIEW
    }
}

struct AboutPageView_Previews: PreviewProvider {
    static var previews: some View {
        AboutPageView()
    }
}
