//
//  Reminder.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 18.07.2022.
//

import SwiftUI

struct Reminder: View {
    @Binding var date: Date?
    @State private var selectedDate: Date = Date()
    @State private var datePickerLogic: Bool = false
    @State private var isDateNil: Bool = true
    var body: some View {
        GroupBox(label: Text(datePickerLogic ? "Hatırlatma Tarih" : "")
            .fontWeight(.bold)
            .font(.title3)
            .frame(maxHeight: datePickerLogic ? 30 : 0)
            .foregroundColor(Color("darkBlue"))
        ){
            if datePickerLogic{
                DatePicker(selection: $selectedDate, displayedComponents: .date, label: {
                    Button(action: {
                        date = selectedDate
                        datePickerLogic.toggle()
                        isDateNil = false
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width: 150, height: 40)
                                .foregroundColor(.white)
                            Text("Ekle")
                        }
                    })
                })
            }else{
                HStack{
                    Button(action: {
                        withAnimation{
                            if isDateNil{
                            datePickerLogic.toggle()
                            } else {
                                isDateNil = true
                                date = nil
                            }
                        }
                    }, label: {
                        HStack(spacing: 10){
                            Image(systemName: isDateNil ? "plus.circle" : "minus.circle")
                                .foregroundColor(Color("darkRed"))
                                .font(.system(size: 26, weight: .medium, design: .default))
                            Text(isDateNil ? "Hatırlatıcı Ekle" : "Hatırlatıcı Kaldır")
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                        .accentColor(Color("darkBlue"))
                       
                    })
                    Spacer()
                    Text(isDateNil ? "" : selectedDate.converToString())
                }
            }
            
        }
        .padding(.horizontal)

    }
}

struct Reminder_Previews: PreviewProvider {
    static var previews: some View {
        Reminder(date: .constant(nil))
    }
}
