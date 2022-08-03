//
//  OtherInfos.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 18.07.2022.
//

import SwiftUI

struct OtherInfos: View {
    @Binding var progress: Progress
    @State var showDisclosure: Bool = false
    var body: some View {
        GroupBox(content: {
            DisclosureGroup(isExpanded:$showDisclosure ,content: {
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                ForEach(Progress.allCases,id:\.self){ progressCase in
                    Text(progressCase.rawValue)
                        .onTapGesture {
                            progress = progressCase
                            showDisclosure.toggle()
                            
                        }
                }
                })
                .padding(.top,10)
            }, label: {
               HStack{
                Text("İlan Durumu")
                Spacer()
                Text(progress.rawValue)
               }
            })
        }, label: {
            GroupBoxLabelView(title: "Diğer Bilgileri", imageName: "folder.badge.plus")
        })
        .padding(.horizontal)
    }
}

struct OtherInfos_Previews: PreviewProvider {
    static var previews: some View {
        OtherInfos(progress: .constant(.ongoing))
    }
}
