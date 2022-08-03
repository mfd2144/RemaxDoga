//
//  NewSharedView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI
import PhotosUI

struct NewSharedView: View {
    // MARK: - Properties
    @Binding var willUpdatedItem: SharedItem?
    @State private var isDisable: Bool = false
    @State private var title: String = ""
    @State private var urgency: Urgency = .low
    @State private var price: String = ""
    @State private var note: String = ""
    @State private var type: RealEstateType?
    @State private var condition: RealEstateCondition?
    @State private var landType: LandType?
    @State private var coefficent: LandCoefficient?
    @State private var place: Places?
    @State private var isTextFieldOpen: Bool = false
    @State private var buttonPressed: Bool = false
    @State private var images: [UIImage] = []
    @State private var newImages: [UIImage] = []
    @State private var showSheet = false
    @State private var info: CustomAlertItem?
    @Binding var isNewItemShown: Bool
    @EnvironmentObject var loginCondition: LogingCondition
    @State var addNewPhotosPressed: Bool = false
    private let errorMessage: String = "İlanınız kaydedilirken bir hata ile karşılaşıldı."
    private let infoMessage: String = "İlan başarıyla eklendi."
    private let cautionMessage: String = "Boş alanları lütfen doldurunuz."
    var isUpdate:Bool{
        return willUpdatedItem != nil
    }
    var manager: SharedDataManager
    // MARK: - Functions
    private func saveData() {
        if willUpdatedItem != nil {
            let item = updateSharedItem()
            guard let item = item else {
                return
            }
            isDisable = true
            manager.updateItem(item: item, uiimages: newImages){ result  in
                isDisable = false
                switch result{
                case .error(let error):
                    print(error)
                    info = CustomAlertItem(id: .error, title: "Hata", message: errorMessage)
                case.success:
                    info = CustomAlertItem(id: .success, title: "Bilgi", message: infoMessage)
                }
            }
        } else {
            let item = createNewSharedItem()
            guard let item = item else {
                return
            }
            isDisable = true
            manager.pushNewSharedItems(item: item, uiimages: images) { result  in
                isDisable = false
                switch result{
                case .error(let error):
                    print(error)
                    info = CustomAlertItem(id: .error, title: "Hata", message: errorMessage)
                case.success:
                    info = CustomAlertItem(id: .success, title: "Bilgi", message: infoMessage)
                }
            }
        }
    }
    //Update existed item
    private func updateSharedItem() -> SharedItem?{
        guard let oldItem = willUpdatedItem, let type = type, let condition = condition, let place = place,  price != "", title != "" else {
            info = CustomAlertItem(id: .emptyBox, title: "İkaz", message: cautionMessage)
            return nil
        }
        guard loginCondition.user == oldItem.user else {
            return nil
        }
        let item = SharedItem(id:oldItem.id , images: oldItem.images, user: oldItem.user, propertyName: title, place: place, estateType: type, estateCondition: condition, landType: landType, display: oldItem.display, coefficient: coefficent, price: price, urgency: .top, notes: note, createDate: oldItem.createDate)
        return item
    }
    //Create new item
    private func createNewSharedItem() -> SharedItem?{
        guard let type = type, let condition = condition, let place = place,  price != "", title != "" else {
            info = CustomAlertItem(id: .emptyBox, title: "İkaz", message: cautionMessage)
            return nil
        }
        guard let user = loginCondition.user else {
            return nil
        }
        let item = SharedItem(images:[] , user: user, propertyName: title, place: place, estateType: type, estateCondition: condition, landType: landType, coefficient: coefficent, price: price, urgency: urgency, notes: note)
        return item
    }
    // MARK: - Body
    var body: some View {
        NavigationView{
            ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack (alignment: .center, spacing: 15) {
                            NewSharedPhotos(images: $images, addPressed: $addNewPhotosPressed, newImages: $newImages, isUpdate:isUpdate )
                            SharedInformation(title: $title, price: $price)
                            EstateInformation(type: $type, condition: $condition, landType: $landType, landCoefficient: $coefficent, place: $place)
                            UrgencyView(urgency: $urgency)
                            NoteView( open: $isTextFieldOpen, noteString: $note)
                            //Save or update button
                            NewItemFooterView(saveButtonPressed: $buttonPressed, buttonText: "Bilgileri Kaydet")
                                .id(1)
                        }
                        .onChange(of: buttonPressed) { _ in
                           saveData()
                        }
                     
                    }// End: -ScrollView
                    .navigationTitle(willUpdatedItem != nil ? "İlan Güncelle" : "İlan Ekle")
                    .toolbar {
                        ToolbarItem(placement:.navigationBarTrailing) {
                            HStack{
                                Button (action:{
                                    //AddNewItem
                                    withAnimation {
                                        isNewItemShown.toggle()
                                    }
                                } ,label: {
                                    Image(systemName: "xmark.circle")
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                })
                                }
                            .accentColor(Color("darkBlue"))
                            }
                    }// End: -Toolbar
                    .alert(item: $info, content: {alert in
                        Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Ok")){
                            print(alert.id)
                            if alert.id == .success{
                                isNewItemShown = false
                            }
                        })
                    })
                    .onAppear {
                        if let oldItem = willUpdatedItem{
                            title = oldItem.propertyName
                            price = oldItem.price
                            place = oldItem.place
                            urgency = oldItem.urgency
                            condition = oldItem.estateCondition
                            coefficent = oldItem.coefficient
                            landType = oldItem.landType
                            type = oldItem.estateType
                            StorageManager.shared.fetchAllImages(imagesRef: oldItem.images) { result in
                                switch result{
                                case.success(let loadedImages):
                                    guard let loadedImages = loadedImages else {return}
                            images = loadedImages
                                case.error:
                                    info = CustomAlertItem(id: .error, title: "Hata", message: "Fotoğraflar yüklenemedi.")
                                }
                                
                            }
                        }
                }

                
            }// End: -Reader
        }// End: -NavigationView
    }
}
struct NewSharedView_Previews: PreviewProvider {
    static var previews: some View {
        NewSharedView( willUpdatedItem: .constant(nil), isNewItemShown: .constant(true), manager: SharedDataManager.shared)
            .environmentObject(LogingCondition())
    }
}

