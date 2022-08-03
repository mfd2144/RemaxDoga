//
//  NewSharedPage.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 27.06.2022.
//

import SwiftUI

struct SharedDetailPage: View {
    var sharedItem: SharedItem
    @State var images:[UIImage] = []
    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.vertical, showsIndicators: false) {
                TitleView(item: sharedItem)
                SharedPhotos(item: sharedItem)
                GeneralInfosView(item: sharedItem)
                SharedEstateInformations(item: sharedItem)
                if let notes = sharedItem.notes {
                    SharedNotesView(notes: notes)
                }
                Spacer()
            }
            .navigationTitle("İlan Detayları")
        }
        
    }
}

struct SharedDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        SharedDetailPage(sharedItem: sharedItems[1])
    }
}
