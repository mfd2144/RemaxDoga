//
//  NoteView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 10.06.2022.
//

import SwiftUI


struct NoteView: View {
    @Binding var open: Bool
    @Binding var noteString: String
    var body: some View {
        GroupBox(label: Text(open ? "Not" : "")
            .fontWeight(.bold)
            .font(.title3)
            .frame(maxHeight: open ? 30 : 0)
            .foregroundColor(Color("darkBlue"))
        ) {
        if !open {
            HStack{
                Button(action: {
                    withAnimation{
                        open.toggle()
                    }
                }, label: {
                    HStack(spacing: 10){
                        Image(systemName:"plus.circle")
                            .foregroundColor(Color("darkRed"))
                            .font(.system(size: 26, weight: .medium, design: .default))
                        Text("Not Ekle")
                            .fontWeight(.bold)
                            .font(.title3)
                    }
                    .accentColor(Color("darkBlue"))
                   
                })
                Spacer()
            }
        } else {
                TextView(
                text: $noteString
                )
                .frame( height:200 ,alignment: .topTrailing)
                .overlay(alignment: .topTrailing, content: {
                    Button(action: {
                        noteString = ""
                        open.toggle()
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color("darkRed"))
                            .font(.system(size: 26, weight: .medium, design: .default))
                    })
                    .offset(y:-40)
                })
            }
        }// End: -GroupBox
        .padding(.horizontal)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(open: .constant(true), noteString: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}



