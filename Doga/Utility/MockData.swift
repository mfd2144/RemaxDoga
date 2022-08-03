//
//  MockDatas.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 10.07.2022.
//

import Foundation
let adres = "https://www.sahibinden.com/ilan/emlak-arsa-satilik-remax-doga-dan-cavus-mahallesinde-510-m2-satilik-arsa-1030139103/detay/"
var exampleData: [CalledCommercial] = [CalledCommercial(id: "1234567",
                                                    adOwner: "Arzu Hanım",
                                                        phoneNumber: "1234567", adLink: adres, date: Date().timeIntervalSince1970, places: .CAVUS_MAHALLESI, adDate:Date().timeIntervalSince1970, progress: .ongoing, user: .MFD, notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", type: .apartment, condition: .forSale, landType: nil, landCoefficient: nil),
                                       CalledCommercial(id: "12345627", adOwner: "Mahmut", phoneNumber: "1234567", adLink: adres, date: Date().timeIntervalSince1970, places: .CAVUS_MAHALLESI, progress: .positive, user: .MFD, notes: "Mock Data", type: .land, condition: .forSale, landType: .construction, landCoefficient: .fifthy),
                                       CalledCommercial(id: "123445567", adOwner: "Yusuf", phoneNumber: "11234567", adLink: adres, date: Date().timeIntervalSince1970, places: .CAVUS_MAHALLESI, progress: .negative, user: .MFD, notes: nil, type: .land, condition: .forSale, landType: .construction, landCoefficient: .fifthy),
                                     CalledCommercial(id: "8765432345",
                                                    adOwner: "Asuman hanım",
                                                    phoneNumber: "05312334455",
                                                    adLink: "https://www.sahibinden.com/ilan/emlak-konut-satilik-sahibinden-satilik-havuzlu-saunali-lux-villa-981823864/detay",
                                                    date: nil, places: .CAVUS_MAHALLESI,
                                                    progress: .positive,
                                                    user: .Gizem,
                                                    notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                                    type: .apartment, condition: .forSale, landType: nil, landCoefficient: nil),
                                     CalledCommercial(id: "5432234567", adOwner: "Hakkı Hakan", phoneNumber: "055555555", adLink: "https://ofisim.sahibinden.com/ilanlarim/1030440467", date: nil, places: .AKCAKESE_MAHALLESI, progress: .positive, user: .Pinar, notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", type: .land, condition: .forSale, landType: .construction, landCoefficient: .thirtyFive)
]


let commercials:[WebCommercial] = [
    WebCommercial(itemTitle: "REMAX DOĞA'DAN ÇAVUŞ MAHALLESİNDE 510 M2 SATILIK ARSA",
                  itemDetail: "510 m²",
                  price: "3.350.000 ₺",
                  link: "/portfoy/P42511618",
                  thumbnail: "https://i.remax.com.tr/photos/76/733176/T/c5506ee97485494d8588da81d26a02a4.jpg",
                  place: "İstanbul Anadolu / Şile / Çavuş Mah."),
    WebCommercial(itemTitle: "REMAX DOĞA'DAN-ORMANLAR İÇERİSİNDE ÖZEL ÇİFTLİK VEYA KAMP ALANI",
                  itemDetail: "13.034 m²",
                  price: "13.034 m²",
                  link: "/portfoy/P14744341",
                  thumbnail: "https://i.remax.com.tr/photos/66/728866/T/d30b269bd6464d3080c56695ecf5d888.jpg",
                  place: "İstanbul Anadolu / Şile / Bıçkıdere Mah.")
]


let sharedItems: [SharedItem] = [
    SharedItem(images: ["11","22"], user: .Emine, propertyName: "Satılık daire", place: .CAVUS_MAHALLESI, estateType: .flat, estateCondition: .forSale, landType: nil, coefficient: nil, price: "2.500.000", urgency: .top, notes: "5 yıl altında"),
    SharedItem(images: ["11","22"], user: .MFD, propertyName: "Karacaköyde 2500 m2 0.30 emsal arsa", place: .IMRENLI_MAHALLESI, estateType: .land, estateCondition: .forSale, landType: .construction, coefficient: .thirty, price: "8.500.000", urgency: .top, notes: "Kat karşılığı kabul ediyor"),
    SharedItem(images: ["11","22"], user: .Omer, propertyName: "Satılık apartman", place: .BALIBEY_MAHALLESI, estateType: .apartment, estateCondition: .forSale, landType: nil, coefficient: nil, price: "7.500.000", urgency: .top, notes: "Pazarlık payı var"),
    SharedItem(images: ["11","22"], user: .MFD, propertyName: "Satılık 3+1 villa", place: .CAVUS_MAHALLESI  , estateType: .villa, estateCondition: .forSale, landType: nil , coefficient: nil, price: "8.500.000", urgency: .top, notes: "Havuzlu, sauna, giyinme dolabı"),
]

