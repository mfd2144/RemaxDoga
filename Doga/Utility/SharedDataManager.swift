//
//  SharedDataManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 27.06.2022.
//

import Foundation
import FirebaseFunctions
import SwiftUI


class SharedDataManager: ObservableObject {
    static let shared :SharedDataManager = SharedDataManager()
    @Published var data: [SharedItem] = []
    private let function = Functions.functions(region: "europe-west1")
    private var timeStamp: TimeInterval
    private var previousTimeStamp: TimeInterval?
    private init(){
        timeStamp = Date().timeIntervalSince1970
    }
    // MARK: - PushData
    
    func pushNewSharedItems(item: SharedItem, uiimages:[UIImage?], completion:@escaping (Results<Any>) -> ()) {
        if uiimages != []{
            let imagesData = uiimages.compactMap{$0?.convertData()}
       
            StorageManager.shared.createNewStorage(imagesData: imagesData, uuid: item.id) { [weak self] result in
                switch result{
                case .error:
                    completion(result)
                case.success:
                    guard let self = self else {return}
                    let counter = imagesData.count
                    self.pushSharedItemsToDB(item: item, counter, completion: completion)
                }
            }
            
        } else {
            pushSharedItemsToDB(item: item, counter, completion: completion)
        }
    }
    
    private func pushSharedItemsToDB(item: SharedItem ,_ imageCounter: Int,completion:@escaping (Results<Any>) -> ()) {
        // set image ref
        var copyItem: SharedItem = item
        var ref:[String]{
            var array: Array<String> = []
            for index in 0..<imageCounter {
                array.append("sharedImages/\(item.id)/\(index).jpg")
            }
            return array
        }
        // if there isn't any information about land program set it nil
        var itemType: String?
        var itemCoefficient: String?
        if let type = item.landType?.rawValue{
            itemType = type
        } else {
            itemType = LandType.empty.rawValue
            copyItem.landType = LandType.empty
        }
        if let coefficent = item.coefficient?.rawValue {
            itemCoefficient = coefficent
        } else {
            itemCoefficient = LandCoefficient.zero.rawValue
            copyItem.coefficient = LandCoefficient.zero
        }
        let data: Dictionary<String,Any> = ["id": item.id,
                                            "createDate":item.createDate,
                                            "imagesRef": ref,
                                            "user": item.user.rawValue,
                                            "propertyName": item.propertyName,
                                            "place": item.place.rawValue,
                                            "display": 0,
                                            "estateCondition": item.estateCondition.rawValue,
                                            "estateType": item.estateType.rawValue,
                                            "landType": itemType as Any,
                                            "coefficient": itemCoefficient as Any,
                                            "price": item.price,
                                            "urgency": item.urgency.rawValue,
                                            "notes": item.notes
        ]
    
        function.httpsCallable("saveSharedData").call(data) { result, error in
            if let error = error {
                completion(.error(error))
            } else {
                copyItem.images = ref
                self.data.insert(copyItem, at: 0)
                completion(.success(nil))
            }
        }
    }
    
    // MARK: - PullData
    func fetchSharedItems(completion:@escaping (Results<Any>) -> ()) {
        guard previousTimeStamp != timeStamp else {return completion(.success(nil))}
        previousTimeStamp = timeStamp
        function.httpsCallable("fetchSharedItems").call(["timeStamp":timeStamp]) { [weak self] result, error in
            guard let self = self else {return completion(.error(CustomError.optionalError))}
            if let error = error {
                completion(.error(error))
            }
            guard let response = result?.data as? NSDictionary,let array = response["array"] as? NSArray as? [Dictionary<String,Any>] else {completion(.error(CustomError.fetchSharedItemsError))
                return}
            var purchaseItems:[SharedItem] = []
            array.forEach({
                guard let id = ($0["id"] as? String)?.makeTurkish(),
                      let userRawValue = ($0["broker"] as? String)?.makeTurkish(),
                      let placeRawValue = ( $0["place"] as? String)?.makeTurkish(),
                      let display = $0["display"] as? Int,
                      let coefficientRawValue = ($0["coefficient"] as? String)?.makeTurkish(),
                      let propertyName = ($0["propertyName"] as? String)?.makeTurkish(),
                      let estateTypeRawValue = ($0["estateType"] as? String)?.makeTurkish(),
                      let landTypeRawValue = ($0["landType"] as? String)?.makeTurkish(),
                      let price = ($0["price"] as? String)?.makeTurkish(),
                      let estateConditionRawValue = ($0["estateCondition"] as? String)?.makeTurkish(),
                      let urgencyRawValue = ($0["urgency"] as? String)?.makeTurkish(),
                      let notes = ($0["notes"] as? String)?.makeTurkish(),
                      let createDate = $0["createDate"] as? TimeInterval,
                      let imageRef = $0["imageRef"] as? Array<String>
                else { completion(.error(CustomError.dataParseError)); return}
                
                guard let user = Users.init(rawValue: userRawValue),
                      let place = Places.init(rawValue: placeRawValue),
                      let coefficient = LandCoefficient.init(rawValue: coefficientRawValue),
                      let estateType = RealEstateType.init(rawValue: estateTypeRawValue),
                      let estateCondition = RealEstateCondition.init(rawValue: estateConditionRawValue),
                      let landType = LandType.init(rawValue: landTypeRawValue),
                      let urgency = Urgency.init(rawValue: urgencyRawValue) else {
                    return completion(.error(CustomError.dataEnumConvertError))
                }
                let item = SharedItem(id: id,
                                      images: imageRef,
                                      user: user,
                                      propertyName: propertyName,
                                      place: place,
                                      estateType: estateType,
                                      estateCondition:estateCondition ,
                                      landType: landType, display: display,
                                      coefficient: coefficient,
                                      price: price,
                                      urgency: urgency,
                                      notes: notes,
                                      createDate:createDate )

                purchaseItems.append(item)
            })
            // prevent call function when all list shown
            self.timeStamp = purchaseItems.last?.createDate ?? self.timeStamp
            self.data.append(contentsOf: purchaseItems)
            completion(.success(nil))
        }
    }
    // MARK: - Delete data
    func deleteSharedItem(_ item: SharedItem, comletion:@escaping((Results<String?>)->Void)){
        let functionData = ["id":item.id]
        function.httpsCallable("deleteSharedItem").call(functionData) { [weak self] result, error in
            guard let self = self else {return}
            if let error = error {
                comletion(.error(error))
            } else {
                StorageManager.shared.deleteAlbum(item.id,imageRef: item.images)
                guard let index = self.data.firstIndex(of: item) else {return}
                self.data.remove(at: index)
            }
            
        }
    }
    // MARK: - Update data
    func updateItem(item: SharedItem, uiimages:[UIImage?], completion: @escaping(Results<Any>)->()) {
        if uiimages != []{
            let imagesData = uiimages.compactMap{$0?.convertData()}
            StorageManager.shared.createNewStorage(imagesData: imagesData, counter: item.images.count, uuid: item.id) { [weak self] result in
                switch result{
                case .error:
                    completion(result)
                case.success:
                    guard let self = self else {return}
                    let counter = imagesData.count
                    self.updateItemDB(item: item, counter, completion: completion)
                }
            }
        } else {
            updateItemDB(item: item, counter, completion: completion)
        }
    }
    private func updateItemDB(item: SharedItem ,_ imageCounter: Int,completion:@escaping (Results<Any>) -> ()){
        var copyItem: SharedItem = item
        // set image ref
        var newRef:[String]{
            var array: Array<String> = []
            for index in item.images.count..<imageCounter+item.images.count {
                array.append("sharedImages/\(item.id)/\(index).jpg")
            }
            return array
        }
        var ref:[String]{
            item.images + newRef
        }
        // if there isn't any information about land program set it nil
        var itemType: String?
        var itemCoefficient: String?
        if let type = item.landType?.rawValue{
            itemType = type
        } else {
            itemType = LandType.empty.rawValue
            copyItem.landType = LandType.empty
        }
        if let coefficent = item.coefficient?.rawValue {
            itemCoefficient = coefficent
        } else {
            itemCoefficient = LandCoefficient.zero.rawValue
            copyItem.coefficient = LandCoefficient.zero
        }
        
        if item.estateType != .land{
            copyItem.coefficient = .zero
            copyItem.landType = .empty
        }
        let savedData: Dictionary<String,Any> = ["id": item.id,
                                            "createDate":item.createDate,
                                            "imagesRef": ref,
                                            "user": item.user.rawValue,
                                            "propertyName": item.propertyName,
                                            "place": item.place.rawValue,
                                            "display": 0,
                                            "estateCondition": item.estateCondition.rawValue,
                                            "estateType": item.estateType.rawValue,
                                            "landType": itemType as Any,
                                            "coefficient": itemCoefficient as Any,
                                            "price": item.price,
                                            "urgency": item.urgency.rawValue,
                                            "notes": item.notes
        ]
        function.httpsCallable("updateShareItem").call(savedData) { [weak self] result, error in
            guard let self = self else {return}
            if let error = error {
                completion(.error(error))
            } else {
                completion(.success(nil))
                copyItem.images = ref
                guard let index = self.data.firstIndex(of: item) else {return}
                self.data.remove(at: index)
                self.data.insert(copyItem, at: index)
            }
        }
    }
    
    
}
