//
//  SharedItemCell.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 27.06.2022.
//

import SwiftUI

struct SharedItemCell: View {
    // MARK: - Properties
    var sharedData: SharedItem
    @EnvironmentObject var loginCondition: LogingCondition
    @Binding var isNewItemShown: Bool
    @Binding var info: CustomAlertItem?
    @Binding var updatedData: SharedItem?
    @Binding var isEditing: Bool
    // MARK: - Functions
    private func update()->Void {
        if loginCondition.user == sharedData.user{
            updatedData = sharedData
            isNewItemShown.toggle()
        } else {
            info = CustomAlertItem(id: .caution, title: "İkaz", message: "İlan sahibi broker değiştirebilir ve ya silebilir.")
        }
    }
    // MARK: - Body
    @State var uiImage:UIImage = UIImage(systemName:"photo.artframe")!
    var body: some View {
        // MARK: - Placeholder
        HStack {
            ZStack{
            Color.orange.frame(width: isEditing ? 50 : 0, height: 150)
                .opacity( isEditing ? 1.0 : 0.0)
            Text("Güncelle")
                    .foregroundColor(.white)
                    .rotationEffect(Angle.degrees(270))
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .frame(width: isEditing ? 90 : 0)
                    .onTapGesture {
                       update()
                    }
            }
            VStack {
                Text(sharedData.propertyName)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .bold, design: .default))
                HStack(alignment: .center, spacing: 5) {
                    Image(uiImage: uiImage)
                        .imageModifier()
                        .cornerRadius(10)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10){
                        Text("\(sharedData.estateCondition.rawValue) \(sharedData.estateType.rawValue)")
                        Text(sharedData.price)
                        Text("Aciliyeti:  \(sharedData.urgency.rawValue)")
                    }// End: -Vstack
                    .font(.title3)

                }
                .frame( height: 100)
                HStack() {
                    Text(changeString(value:sharedData.place.name)!)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Spacer()
                }
            }// End: -Vstack
            .padding()
            .onAppear {
                let path = "sharedImages/\(sharedData.id)/\(sharedData.display).jpg"
                StorageManager.shared.fetchDisplayImage(imagePath: path) { result in
                    switch result{
                    case .success(let image):
                        guard let image = image else {return}
                        uiImage = image
                    case.error:
                        uiImage = UIImage(systemName: "ant.circle")!
                    }
                    
                }
        }
        }
    }
}

struct SharedItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SharedItemCell(sharedData: sharedItems.first!, isNewItemShown: .constant(false),info: .constant(nil), updatedData: .constant(nil), isEditing: .constant(false))
            .environmentObject(LogingCondition())
    }
}
