//
//  DataManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 9.06.2022.
//

import Foundation
import FirebaseFunctions


class CalledCommercialDataManager:ObservableObject{
    static let share = CalledCommercialDataManager()
    private var timeStamp: TimeInterval
    private var lastItem: Bool = false
    private init() {
        timeStamp = Date().timeIntervalSince1970
        fetchCalledCommercial { result in
            //todo
        }
    }
    @Published var calledCommercials:[CalledCommercial] = []
    @Published var searchedData:[CalledCommercial] = []
    var searchLogic: Bool = false
    // MARK: - Push Data
    func pushCalledItemsToDB(_ item: CalledCommercial, completion: @escaping(Results<String>)->()) {
        var itemType: String?
        var itemCoefficient: String?
        if let type = item.landType?.rawValue{
            itemType = type
        } else {
            itemType = LandType.empty.rawValue
        }
        if let coefficent = item.landCoefficient?.rawValue {
            itemCoefficient = coefficent
        } else {
            itemCoefficient = LandCoefficient.zero.rawValue
        }
        let data: Dictionary<String,Any> = ["id": item.id,
                                            "adOwner":item.adOwner,
                                            "user": item.user.rawValue,
                                            "phoneNumber": item.phoneNumber,
                                            "place": item.places.rawValue,
                                            "progress": item.progress.rawValue,
                                            "estateCondition": item.condition.rawValue,
                                            "estateType": item.type.rawValue,
                                            "landType": itemType as Any ,
                                            "coefficient": itemCoefficient as Any ,
                                            "adLink": item.adLink,
                                            "date": item.date as Any ,
                                            "adDate": item.adDate,
                                            "notes": item.notes as Any
        ]
        Functions.functions(region: "europe-west1").httpsCallable("saveCalledCommercial").call(data) { [weak self] result, error in
            guard let self = self else {return}
            if let error = error {
                completion(.error(error))
            } else {
                guard let response = result?.data as? NSDictionary, let stringResult = response["result"] as? String else {completion(.error(CustomError.fetchCalledItemsError))
                    return}
                if stringResult == "exist"{
                    completion(.error(CustomError.itemAlreadyExist))
                } else {
                    self.calledCommercials.insert(item, at: 0)
                    completion(.success(nil))
                }
            }
        }
    }
    // MARK: - Fetch Data
    func fetchCalledCommercial(completion:@escaping (Results<Any>) -> ()) {
        guard !lastItem else {return completion(.success(nil))}
        Functions.functions(region: "europe-west1").httpsCallable("fetchCalledCommercial").call(["timeStamp":timeStamp]) { [weak self] result, error in
            guard let self = self else {return completion(.error(CustomError.optionalError))}
            if let error = error {
                print(error)
                completion(.error(error))
            }
            guard let response = result?.data as? NSDictionary,let array = response["array"] as? NSArray as? [Dictionary<String,Any>] else {completion(.error(CustomError.fetchSharedItemsError))
                return}
            var calledItem: [CalledCommercial] = []
            array.forEach({
                guard let id = ($0["id"] as? String)?.makeTurkish(),
                      let userRawValue = ($0["broker"] as? String)?.makeTurkish(),
                      let placeRawValue = ( $0["place"] as? String)?.makeTurkish(),//
                      let adOwner = ($0["adOwner"] as? String)?.makeTurkish(),
                      let coefficientRawValue = ($0["coefficient"] as? String)?.makeTurkish(),
                      let phoneNumber = ($0["phoneNumber"] as? String)?.makeTurkish(),//
                      let estateTypeRawValue = ($0["estateType"] as? String)?.makeTurkish(),
                      let landTypeRawValue = ($0["landType"] as? String)?.makeTurkish(),//
                      let progressRawValue = ($0["progress"] as? String)?.makeTurkish(),//
                      let estateConditionRawValue = ($0["estateCondition"] as? String)?.makeTurkish(),
                      let adDate = $0["adDate"] as? TimeInterval,
                      let notes = ($0["notes"] as? String)?.makeTurkish(),//
                      let adLink = $0["adLink"] as? String
                else { completion(.error(CustomError.dataParseError)); return}
                
                guard let user = Users.init(rawValue: userRawValue),
                      let place = Places.init(rawValue: placeRawValue),
                      let coefficient = LandCoefficient.init(rawValue: coefficientRawValue),
                      let estateType = RealEstateType.init(rawValue: estateTypeRawValue),
                      let estateCondition = RealEstateCondition.init(rawValue: estateConditionRawValue),
                      let landType = LandType.init(rawValue: landTypeRawValue),
                      let progress = Progress.init(rawValue: progressRawValue)
                else {
                    return completion(.error(CustomError.dataEnumConvertError))
                }
                let item = CalledCommercial(id: id,
                                            adOwner: adOwner,
                                            phoneNumber: phoneNumber,
                                            adLink: adLink,
                                            date: $0["date"] as? TimeInterval,
                                            places: place,
                                            adDate: adDate,
                                            progress: progress,
                                            user: user,
                                            notes: notes,
                                            type: estateType,
                                            condition: estateCondition,
                                            landType: landType,
                                            landCoefficient: coefficient)
                calledItem.append(item)
                
            })
            // prevent call function when all list shown
            if calledItem.last?.adDate == nil{
                self.lastItem.toggle()
                completion(.success(nil))
            } else {
                self.timeStamp = calledItem.last?.adDate ?? self.timeStamp
            }
            self.calledCommercials.append(contentsOf: calledItem)
            completion(.success(nil))
        }
    }
    // MARK: - Delete Data
    func deleteData(_ data: CalledCommercial,completion: @escaping(Results<Any>)->()) {
        let id = ["id":data.id]
        Functions.functions(region: "europe-west1").httpsCallable("deleteCalledCommercial").call(id) { result, error in
            if let error = error {
                completion(.error(error))
            } else {
                if let index = self.calledCommercials.firstIndex(of: data) {
                    self.calledCommercials.remove(at: index)
                }
                completion(.success(nil))
            }
        }
    }
    // MARK: - Update Data
    func updateData(_ item: CalledCommercial, completion: @escaping(Results<String>)->()) {
        var itemType: String?
        var itemCoefficient: String?
        if let type = item.landType?.rawValue{
            itemType = type
        } else {
            itemType = LandType.empty.rawValue
        }
        if let coefficent = item.landCoefficient?.rawValue {
            itemCoefficient = coefficent
        } else {
            itemCoefficient = LandCoefficient.zero.rawValue
        }
        let data: Dictionary<String,Any> = ["id": item.id,
                                            "adOwner":item.adOwner,
                                            "user": item.user.rawValue,
                                            "phoneNumber": item.phoneNumber,
                                            "place": item.places.rawValue,
                                            "progress": item.progress.rawValue,
                                            "estateCondition": item.condition.rawValue,
                                            "estateType": item.type.rawValue,
                                            "landType": itemType as Any ,
                                            "coefficient": itemCoefficient as Any ,
                                            "adLink": item.adLink,
                                            "date": item.date as Any ,
                                            "adDate": item.adDate,
                                            "notes": item.notes as Any
        ]
        Functions.functions(region: "europe-west1").httpsCallable("updateCalledCommercial").call(data) { [weak self] result, error in
            guard let self = self else {return}
            if let error = error {
                completion(.error(error))
            } else {
                if let index = self.calledCommercials.firstIndex(of: item) {
                    self.calledCommercials[index] = item
                }
                completion(.success(nil))
            }
        }
    }
    func fetchSearchedCommercials(id: String,completion:@escaping (Results<Any>) -> ()) {
        guard id.count > 5 else {return}
        let idData = ["id":id]
        Functions.functions(region: "europe-west1").httpsCallable("searchCalledCommercial").call(idData) { [weak self] result, error in
            guard let self = self else {return completion(.error(CustomError.optionalError))}
            if let error = error {
                print(error)
                completion(.error(error))
            }
            guard let response = result?.data as? NSDictionary,let array = response["array"] as? NSArray as? [Dictionary<String,Any>] else {completion(.error(CustomError.fetchSharedItemsError))
                return}
            var calledItem: [CalledCommercial] = []
            array.forEach({
                guard let id = ($0["id"] as? String)?.makeTurkish(),
                      let userRawValue = ($0["broker"] as? String)?.makeTurkish(),
                      let placeRawValue = ( $0["place"] as? String)?.makeTurkish(),//
                      let adOwner = ($0["adOwner"] as? String)?.makeTurkish(),
                      let coefficientRawValue = ($0["coefficient"] as? String)?.makeTurkish(),
                      let phoneNumber = ($0["phoneNumber"] as? String)?.makeTurkish(),//
                      let estateTypeRawValue = ($0["estateType"] as? String)?.makeTurkish(),
                      let landTypeRawValue = ($0["landType"] as? String)?.makeTurkish(),//
                      let progressRawValue = ($0["progress"] as? String)?.makeTurkish(),//
                      let estateConditionRawValue = ($0["estateCondition"] as? String)?.makeTurkish(),
                      let adDate = $0["adDate"] as? TimeInterval,
                      let notes = ($0["notes"] as? String)?.makeTurkish(),//
                      let adLink = $0["adLink"] as? String
                else { completion(.error(CustomError.dataParseError)); return}
                guard let user = Users.init(rawValue: userRawValue),
                      let place = Places.init(rawValue: placeRawValue),
                      let coefficient = LandCoefficient.init(rawValue: coefficientRawValue),
                      let estateType = RealEstateType.init(rawValue: estateTypeRawValue),
                      let estateCondition = RealEstateCondition.init(rawValue: estateConditionRawValue),
                      let landType = LandType.init(rawValue: landTypeRawValue),
                      let progress = Progress.init(rawValue: progressRawValue)
                else {
                    return completion(.error(CustomError.dataEnumConvertError))
                }
                let item = CalledCommercial(id: id,
                                            adOwner: adOwner,
                                            phoneNumber: phoneNumber,
                                            adLink: adLink,
                                            date: $0["date"] as? TimeInterval,
                                            places: place,
                                            adDate: adDate,
                                            progress: progress,
                                            user: user,
                                            notes: notes,
                                            type: estateType,
                                            condition: estateCondition,
                                            landType: landType,
                                            landCoefficient: coefficient)
                calledItem.append(item)
            })
            // prevent call function when all list shown
            print(calledItem)
            self.searchedData = calledItem
            completion(.success(nil))
        }
    }
}
