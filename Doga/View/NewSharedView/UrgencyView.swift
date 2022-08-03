//
//  UrgencyView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 25.07.2022.
//

import SwiftUI

struct UrgencyView: View {
    @Binding var urgency: Urgency
    @State var showDisclosure: Bool = false
    var body: some View {
        GroupBox(content: {
            DisclosureGroup(isExpanded:$showDisclosure ,content: {
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                ForEach(Urgency.allCases,id:\.self){ selectedUrgency in
                    Text(selectedUrgency.rawValue)
                        .onTapGesture {
                            urgency = selectedUrgency
                            showDisclosure.toggle()
                        }
                }
                })
                .padding(.top,10)
            }, label: {
               HStack{
                Text("Aciliyeti")
                Spacer()
                   Text(urgency.rawValue)
               }
            })
        }, label: {
            GroupBoxLabelView(title: "Diğer Bilgileri", imageName: "folder.badge.plus")
        })
        .padding(.horizontal)
    }
}

struct UrgencyView_Previews: PreviewProvider {
    static var previews: some View {
        UrgencyView(urgency: .constant(.low))
    }
}
