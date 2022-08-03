//
//  SharedEstateInformations.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI

struct SharedEstateInformations: View {
    var item: SharedItem
    
    func checkLandInfo<T>(item: T?) -> GroupBoxComponentView? {
        if item != nil{
            if let landCoefficient = item as? LandCoefficient{
                return GroupBoxComponentView(title: "Emsal", value: landCoefficient.name)
            } else if let landType = item as? LandType{
                return GroupBoxComponentView(title: "Vasfı", value: landType.name)
            } else {
                return nil
            }
        }else {
            return nil
        }
    }
    var body: some View {
        GroupBox(content: {
            GroupBoxComponentView(title:"Yer Bilgisi", value: changeString(value: item.place.name) ?? "")
            GroupBoxComponentView(title: "Durum", value: item.estateCondition.name)
            GroupBoxComponentView(title: "Mülk Türü", value: item.estateType.name)
            checkLandInfo(item:item.landType )
            checkLandInfo(item: item.coefficient)
            GroupBoxComponentView(title: "Fiyat", value: item.price)
           
        }, label: {
            GroupBoxLabelView(title: "Emlak Bilgileri", imageName: "building.columns.circle")
        })
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct SharedEstateInformations_Previews: PreviewProvider {
    static var previews: some View {
        SharedEstateInformations(item: sharedItems[1])
    }
}
