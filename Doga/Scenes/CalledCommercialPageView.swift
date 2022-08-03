//
//  ContentView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import SwiftUI
import CoreData

struct CalledCommercialPageView: View {
    // MARK: - Proporties
    @Binding var isShown: Bool
    @State var adNumber: String = ""
    @EnvironmentObject var loginCondition: LogingCondition
    @State var willUpdatedData: CalledCommercial?
    @State var showNewItem: Bool = false
    @State private var info: CustomAlertItem?
    @ObservedObject var dataManager = CalledCommercialDataManager.share
    private var searchData:[CalledCommercial] {
        if adNumber.isEmpty{
            dataManager.searchLogic = false
            return dataManager.calledCommercials
        } else {
            dataManager.searchLogic = true
            return dataManager.searchedData
        }
    }
    var cautionText: String = "İlanı sadece giren kişi düzenleyebilir ve ya kaldırabilir."
    // MARK: - Functions
    private func onDelete(data: CalledCommercial) {
        guard data.user == loginCondition.user else {
            info = CustomAlertItem(id: .caution, title: "İkaz", message: cautionText)
            return
        }
        dataManager.deleteData(data) { result in
            switch result {
            case.success:
                break
            case .error:
                info = CustomAlertItem(id: .error, title: "Hata", message: "Silme işlemi yapılamadı. Lütfen tekrar deneyiniz.")
            }
        }
    }
    private func onUpdate(data: CalledCommercial) {
        guard data.user == loginCondition.user else {
            info = CustomAlertItem(id: .caution, title: "İkaz", message: cautionText)
            return
        }
        willUpdatedData = data
        showNewItem = true
    }
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                if !showNewItem {
                    VStack {
                        AdSearchBar(adId: $adNumber)
                            .padding()
                            .animation(.easeIn, value: adNumber)
                        List {
                            ForEach(searchData) { data in
                                NavigationLink {
                                    CalledDetailPage(data: data)
                                } label: {
                                    SlideItem(content: {
                                        AdListView(adData: data)
                                            .onAppear {
                                                if data.id == searchData.last?.id{
                                                    dataManager.fetchCalledCommercial { result in
                                                        switch result{
                                                        case.error:
                                                            info = CustomAlertItem(id: .error, title: "Hata", message: "Yükleme hatası. Lütfen yeniden başlatın")
                                                        default:
                                                            break
                                                        }
                                                    }
                                                }
                                            }
                                    }, left: {
                                       PencilView()
                                        .onTapGesture {
                                            onUpdate(data: data)
                                        }
                                    }, right: {
                                        TrashView()
                                        .onTapGesture {
                                            onDelete(data: data)
                                        }
                                    }, itemHeight: 60, id: data.id)//End SlideItem
                                }// End: -Label
                            }// End: -Loop
                        }// End: -List
                        .toolbar {
                            CustomNavigationBar( showNewItem: $showNewItem,isShown: $isShown)
                        }// End: -toolbar
                        .onAppear {
                            willUpdatedData = nil
                        }
                    }// End: -VStack
                } else {
                    NewCalledItemPage(showNewItem: $showNewItem,willUpdatedData: $willUpdatedData)
                }// End: -VStack
            }// End: -ZStack
            .transition(.slide)
            .alert( item: $info) { alert in
                Alert(title: Text(alert.title), message: Text(alert.message), dismissButton:.cancel(Text("Tamam")))
            }
            .onDisappear {
                SlideManager.shared.slideItemId = ""
            }
        }// End: -NAVIGATIONVIEW
        .navigationBarTitleDisplayMode(.large)
    }
    
}
// MARK: - Previews
struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        CalledCommercialPageView(isShown: .constant(true))
            .environmentObject(LogingCondition())
    }
}
