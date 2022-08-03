//
//  CommercialDataManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 20.06.2022.
//


import Foundation
import FirebaseFunctions

class CommercialDataManager:ObservableObject{
    static let shared = CommercialDataManager()
    @Published var isLoading = true
    @Published var data: [WebCommercial] = []
    private init(){
      fetchData()
    }
    private func fetchData() {
        Functions.functions(region: "europe-west1").httpsCallable("fetchCommercials").call { [weak self] result, error in
            guard let self = self else {return}
            self.isLoading = false
            if let error = error {
                print(error)
            } else {
                guard let array = result?.data as? NSArray else {fatalError()}
               array.forEach { item in
                   guard let item  = item as? Dictionary<String, String> else {fatalError()}
                   let commercial = WebCommercial(itemTitle: item["itemTitle"] ?? "",
                                  itemDetail: item["itemDetail"] ?? "",
                                  price: item["price"] ?? "",
                                  link: item["link"] ?? "",
                                 thumbnail: item["thumbnail"] ?? "",
                                  place: item["place"] ?? "")
                   self.data.append(commercial)
                }
    
            }
        }
    
    }
    
}
