//
//  SharedPage.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 27.06.2022.
//

import SwiftUI

struct SharedPage: View {
    // MARK: - Properties
    @ObservedObject var sharedManager = SharedDataManager.shared
    @EnvironmentObject var loginCondition: LogingCondition
    @Binding var isShown: Bool
    @State var isNewItemShown: Bool = false
    @State private var updatedData: SharedItem?
    @State private var updatePressed: Bool = false
    @State private var isEditing: Bool = false
    @State private var info: CustomAlertItem?
    // MARK: - Functions
    private func isLastItem(_ item: SharedItem) -> Bool{
        if item == sharedManager.data.last{
            return  true
        } else {
            return false
        }
    }
    private func delete2(at offsets: IndexSet){
        if let index = offsets.first{
            let item = sharedManager.data[index]
            delete(item)
        }
    }
    private func delete(_ item: SharedItem)->Void {
        if loginCondition.user == item.user{
            sharedManager.deleteSharedItem(item) { result in
                switch result{
                case.error:
                    info = CustomAlertItem(id: .error, title: "Hata", message: "Paylaşılan ilan silinemedi.")
                case .success:
                    break
                }
            }
        } else {
            info = CustomAlertItem(id: .caution, title: "İkaz", message: "İlan sahibi broker değiştirebilir ve ya silebilir.")
        }
    }
   
    // MARK: - Body
    var body: some View {
        NavigationView{
            List{
                ForEach(sharedManager.data, id: \.id){item in
                    NavigationLink(destination: {
                        SharedDetailPage(sharedItem: item)
                    }, label: {
                        SharedItemCell(sharedData: item, isNewItemShown: $isNewItemShown, info: $info, updatedData: $updatedData, isEditing: $isEditing)
                            .accentColor(.black)
                            .onAppear {
                                if isLastItem(item){
                                    sharedManager.fetchSharedItems { _ in
                                    }
                                }
                            }
                    })
                    .padding(.vertical)
                }
                .onDelete(perform: delete2)
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(.spring(),value: isEditing)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Paylaşılan İlanlar")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button (action:{
                        //AddNewItem
                        withAnimation {
                            isShown.toggle()
                        }
                    } ,label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                    })
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    HStack{
                        Button(action: {
                            self.isEditing.toggle()
                        }, label: {
                            Text(isEditing ? "Done" : "Edit")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(isEditing ? Color("darkRed") : Color("darkBlue"))
                        })
                        Button (action:{
                            //AddNewItem
                            SlideManager.shared.slideItemId = ""
                            withAnimation {
                                isNewItemShown.toggle()
                            }
                        } ,label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                        })
                    }// End: -ToolHStack
                    .navigationBarTitleDisplayMode(.large)
                }
                
            }// End: -ToolBar
            .accentColor(Color("darkBlue"))
            .onAppear(perform: {
                sharedManager.fetchSharedItems { result in
                    switch result{
                    case.error(let error):
                        print(error)
                    default:
                        break
                    }
                }
            })
            .fullScreenCover(isPresented: $isNewItemShown) {
                NewSharedView( willUpdatedItem: $updatedData, isNewItemShown: $isNewItemShown, manager: sharedManager)
            } // End: - FullScreenCover
            .alert(item: $info){ alert in
                Alert(title: Text(alert.title), message: (Text(alert.message)), dismissButton: .default(Text("Tamam")){
                    
                })
            }
            .onChange(of: isNewItemShown) { newValue in
                if newValue == false{
                    updatedData = nil
                }
            }
            .onDisappear {
                SlideManager.shared.slideItemId = ""
            }
        }// End: -NavigationView
    }
}

struct SharedPage_Previews: PreviewProvider {
    static var previews: some View {
        SharedPage( isShown: .constant(true))
    }
}
