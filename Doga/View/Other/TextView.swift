//
//  TextView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 18.07.2022.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String

     func makeCoordinator() -> Coordinator {
         Coordinator(self)
     }

     func makeUIView(context: Context) -> UITextView {

         let myTextView = UITextView()
         myTextView.delegate = context.coordinator

         myTextView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
         myTextView.isScrollEnabled = true
         myTextView.isEditable = true
         myTextView.isUserInteractionEnabled = true
         myTextView.backgroundColor = UIColor.white

         return myTextView
     }

     func updateUIView(_ uiView: UITextView, context: Context) {
         uiView.text = text
     }

     class Coordinator : NSObject, UITextViewDelegate {

         var parent: TextView

         init(_ uiTextView: TextView) {
             self.parent = uiTextView
         }

         func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
             return true
         }

         func textViewDidChange(_ textView: UITextView) {
             self.parent.text = textView.text
         }
     }
}
