//
//  SharedNotesView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 29.06.2022.
//

import SwiftUI

struct SharedNotesView: View {
var notes: String
    var body: some View {
        GroupBox(content: {
            VStack(alignment: .leading){
                Divider()
                Text(notes)
            }
        }, label: {
            GroupBoxLabelView(title: "Notlar", imageName: "note.text")
        })
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct SharedNotesView_Previews: PreviewProvider {
    static var previews: some View {
        SharedNotesView(notes: (sharedItems.first?.notes)!)
    }
}
