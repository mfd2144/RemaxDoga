//
//  CommercialsView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 20.06.2022.
//

import SwiftUI

struct CommercialsView: View {
    @ObservedObject var dataManager = CommercialDataManager.shared
    @State var indicator = true
    var body: some View {
//        LoadingView(isShowing: $indicator) {
            NavigationView{
                VStack {
                    List {
                        ForEach(dataManager.data, id:\.itemTitle) {data in
                          CommercialCellView(data: data)
                                .onTapGesture {
                                    UIApplication.shared.open(URL(string: data.itemLink)!)
                                }
                        }
                        .navigationTitle("Remax Doğa")
                        .onChange(of: dataManager.isLoading) { value in
                            indicator = value
                        }
                    }
                }
            }// End: - NavigationView
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        
                    }, label: {
                        Image("sahibinden")
                    })
                })
            }
//        }
 
    }
}

struct CommercialsView_Previews: PreviewProvider {
    static var previews: some View {
        CommercialsView()
    }
}
