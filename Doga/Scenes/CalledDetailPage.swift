//
//  DetailPage.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 4.06.2022.
//

import SwiftUI

struct CalledDetailPage: View {
    // MARK: - Properties
    let data: CalledCommercial
    @State var animationActivate: Bool = false
    @EnvironmentObject var loginCondition: LogingCondition
    // MARK: - Functions
    private func checkUser() -> Bool {
        return data.user == loginCondition.user
    }
    private func addLink() -> AdLink?{
        guard let _ = URL(string: data.adLink) else {return nil}
       return AdLink(adData: data)
    }
    private func addNewOtherView<T>(title: String, value: T?) -> OtherDetails? {
        if let value = value as? String {
            if title == "Arsa Tipi" || title == "Emsal"{
                if data.type != .land{
                    return nil
                }
            }
            return OtherDetails(title: title, data: value)
        } else if let value = value as? TimeInterval {
            let date = Date(timeIntervalSince1970: value)
            let dateString = date.converToString()
            return OtherDetails(title: title, data: dateString)
        }
        else {
            return nil
        }
    }
    private func slideValue() -> CGFloat {
        counter += 1
        return CGFloat((-50*counter))
    }
    private func addNote() -> NotesView? {
        guard let note = data.notes, !note.isEmpty else {return nil}
        return NotesView(noteString: note)
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            
            DetailHeader(user: data.user)
                .shadow(color: .black.opacity(0.2), radius: 6, x:0 , y: 6)
                .offset(x:animationActivate ? 0 : slideValue())
                .padding(.bottom,10)
            
            VStack(alignment: .center, spacing: 15) {
               
                //AdDetails
               addLink()
                    .offset(x:animationActivate ? 0 : slideValue())
                //Progress
                ProgressView(progress: data.progress)
                    .offset(x:animationActivate ? 0 : slideValue())
                // MARK: - Other Views
                //Owner
                addNewOtherView(title: "Sahibi", value: data.adOwner)
                    .offset(x:animationActivate ? 0 : slideValue())
               //Adding date
                addNewOtherView(title: "Ekleme tarihi", value: data.adDate)
                    .offset(x:animationActivate ? 0 : slideValue())
                //RealEstateCondition
                addNewOtherView(title: "Durum", value: data.condition.rawValue)
                    .offset(x:animationActivate ? 0 : slideValue())
                //RealEstateType
                addNewOtherView(title: "Türü", value: data.type.rawValue)
                    .offset(x:animationActivate ? 0 : slideValue())
                //Place
                addNewOtherView(title: "Yeri", value: changeString(value: data.places.name))
                    .offset(x:animationActivate ? 0 : slideValue())
                //Land type
                addNewOtherView(title: "Arsa Tipi", value: data.landType?.rawValue)
                    .offset(x:animationActivate ? 0 : slideValue())
                //Land coefficient
                addNewOtherView(title: "Emsal", value: data.landCoefficient?.name)
                    .offset(x:animationActivate ? 0 : slideValue())
                
                if checkUser() {
                    if let phone = data.phoneNumber, let url = URL(string: "\(phone)"){
                        AdOwnerPhone(phoneData: phone, url: url)
                            .offset(x:animationActivate ? 0 : slideValue())
                    }
                    addNote()
                        .offset(x:animationActivate ? 0 : slideValue())
                    // reminder
                    addNewOtherView(title: "Hatırlatma", value: data.date)
                        .offset(x:animationActivate ? 0: slideValue())
                }
                
                //Notes
                //Footnote
                
            }// End: -VStack
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0)){
                    animationActivate = true
                    counter = 0
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(
            DetailPageAnimationView()
                .opacity(0.2)
        )
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalledDetailPage( data: exampleData[0])
                .environmentObject(LogingCondition())
        }
    }
}
