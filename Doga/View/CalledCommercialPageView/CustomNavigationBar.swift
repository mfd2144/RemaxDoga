//
//  CustomNavigatıonBar.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 1.06.2022.
//

//
//  CustomNavigatıonBar.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 1.06.2022.
//

import SwiftUI

struct CustomNavigationBar: View {
    // MARK: - Properties
//    @Binding var isFiltered: Bool
    @Binding var showNewItem: Bool
    @Binding var isShown: Bool
    // MARK: - Body
    var body: some View {
        HStack( spacing:10) {
            Image("logo")
                .imageModifier()
                .frame(height: 50)
                .padding(.horizontal)
            Spacer()
//            Button {
//                isFiltered.toggle()
//            } label: {
//                Text("İlanlarım")
//                    .font(.system(size: 20, weight: .medium, design: .default))
//            }
            Button (action:{
                //AddNewItem
                withAnimation {
                    showNewItem.toggle()
                }
            } ,label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            })
            
            Button (action:{
                //AddNewItem
                withAnimation {
                    isShown.toggle()
                }
            } ,label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            })
            
        }// End: -HStack
        .accentColor(Color("darkBlue"))
    }
}
struct CustomNavigat_onBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar( showNewItem: .constant(false),isShown: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
