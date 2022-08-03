//
//  NewItemPage.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 6.06.2022.
//

import SwiftUI

struct NewCalledItemPage: View {
    // MARK: - Properties
    @Binding var showNewItem: Bool
    @EnvironmentObject var loginCondition: LogingCondition
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var adID: String = ""
    @State private var adLink: String = ""
    @State private var info: CustomAlertItem?
    @State private var type: RealEstateType?
    @State private var isTextFieldOpen: Bool = false
    @State private var progress: Progress = Progress.ongoing
    @State private var date: Date?
    @State var condition: RealEstateCondition?
    @State var landType: LandType?
    @State var landCoefficient: LandCoefficient?
    @State var place: Places?
    @State var note:String = ""
    @State var buttonPressed:Bool = false
    @State var updatePage:Bool = false
    @State private var choiceBox: Int = 1
    @Binding var willUpdatedData: CalledCommercial?
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    // MARK: - Functions
    private func saveData() {
        guard loginCondition.user != nil,
              !name.isEmpty,
              !adID.isEmpty,
              type != nil ,
              condition != nil,
              place != nil else {
            print("burada?????")
            info = CustomAlertItem(id: .caution, title: "ikaz", message: "Lütfen bütün alanları doldurun.")
            return
        }
        if type == .land{
            guard landType != nil, landCoefficient != nil else {
                info = CustomAlertItem(id: .caution, title: "ikaz", message: "Lütfen bütün alanları doldurun.")
                return
            }
        }
        let calledCommercial = CalledCommercial(id: adID, adOwner: name, phoneNumber: phoneNumber, adLink: adLink, date: date?.timeIntervalSince1970, places: place! , progress: progress, user: loginCondition.user!, notes: note, type: type!, condition: condition!, landType: landType, landCoefficient: landCoefficient)
        
        if willUpdatedData == nil { CalledCommercialDataManager.share.pushCalledItemsToDB(calledCommercial) { result in
            switch result {
            case .success:
                info = CustomAlertItem(id: .success, title: "Bilgi", message: "Aranan ilan başarıyla kaydedildi")
            case .error(let error):
                if error as? CustomError == .itemAlreadyExist{
                    info = CustomAlertItem(id: .error, title: "İkaz", message: " Bu ilan önceden eklendi. Lütfen aranan ilanları kontrol ediniz.")
                } else {
                    info = CustomAlertItem(id: .error, title: "Hata", message: "Aranan ilan kaydedilemedi. ")
                }
            }
        }
        }else {
            CalledCommercialDataManager.share.updateData(calledCommercial){ result in
                switch result {
                case .success:
                    info = CustomAlertItem(id: .success, title: "Bilgi", message: "Aranan ilan başarıyla güncellendi")
                case .error:
                    info = CustomAlertItem(id: .error, title: "Hata", message: "Aranan ilan güncellenemedi.")
                }
            }
        }
        withAnimation {
            showNewItem.toggle()
        }
    }
    private func loadData() {
        if willUpdatedData != nil{
            updatePage = true
            isTextFieldOpen = true
            name = willUpdatedData?.adOwner ?? ""
            adID = willUpdatedData?.id ?? ""
            phoneNumber = willUpdatedData?.phoneNumber ?? ""
            adLink = willUpdatedData?.adLink ?? ""
            type = willUpdatedData?.type
            condition = willUpdatedData?.condition
            landType = willUpdatedData?.landType
            landCoefficient = willUpdatedData?.landCoefficient
            note = willUpdatedData?.notes ?? ""
            place = willUpdatedData?.places
            progress = willUpdatedData!.progress
            if let reminderDate = willUpdatedData?.date{
                date = Date(timeIntervalSince1970: reminderDate)
            }
        }
    }
    // MARK: - Body
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center,spacing: 15) {
                    //Information about ad data
                    AdInformationView(adID: $adID, adLink: $adLink,lock:updatePage)
                        .id(1)
                        .onTapGesture {
                            choiceBox = 1
                        }
                    // Information about ad owner
                    AdOwnerInformationView(name: $name, phoneNumber: $phoneNumber)
                        .id(2)
                        .onTapGesture {
                            choiceBox = 2
                        }
                    //Real estate information
                    EstateInformation(type: $type, condition: $condition, landType: $landType, landCoefficient: $landCoefficient, place: $place)
                    //Progress and remender
                    OtherInfos(progress: $progress)
                    Reminder(date:$date)
                    //Note view
                    NoteView( open: $isTextFieldOpen, noteString: $note)
                    //Save or update button
                        .onTapGesture {
                            choiceBox = 3
                        }
                    NewItemFooterView(saveButtonPressed: $buttonPressed, buttonText: updatePage ? "Bilgileri Güncelle" : "Bilgileri Kaydet")
                        .id(3)
                }// End: -VStack
                .onChange(of:keyboardResponder.keybordAppear ) { _ in
                    proxy.scrollTo(choiceBox)
                }
                .onTapGesture {
                    hideKeybord()
                }
                .navigationTitle(updatePage ? "İlan Güncelleme":"Yeni İlan")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NewCalledItemToolBar(updatePage: updatePage, showNewItem: $showNewItem, buttonPressed: $buttonPressed)
                            .alert(item: $info) { alert in
                                Alert(title: Text(alert.title), message: Text(alert.message), dismissButton:.default(Text("Tamam")))
                            }
                    }// End: -ToolBarItem
                }// End: -ToolBar
                .onChange(of: buttonPressed) { _ in
                    saveData()
                }
            }// End: -ScrollView
        }// End: -Proxy
       
        .onAppear {
            loadData()
        }
    }
}

struct NewItemPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewCalledItemPage(showNewItem: .constant(true), willUpdatedData: .constant(nil) )
        }
    }
}
