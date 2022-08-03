//
//  StorageManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 8.07.2022.
//

import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    lazy var sharedImagesRef = storageRef.child("sharedImages")
    private init() {}
    
    func createNewStorage(imagesData: [Data],counter:Int = 0, uuid: String, completion:@escaping (Results<Any>) ->()){
        let bucketRef = sharedImagesRef.child(uuid)
        var inletCounter = counter
        for  data in imagesData {
            let imageRef = bucketRef.child("\(inletCounter).jpg")
            print(imageRef)
            inletCounter += 1
            imageRef.putData(data, metadata: nil) {
                (metadata, error) in
                if let error = error {
                    completion(.error(error))
                }
                guard let meta = metadata else {
                    return completion(.error(CustomError.emptyMetaData))
                }
                print(meta)
            }
        }
        print("inlet \(inletCounter)")
        print("counter \(counter)")
        print(imagesData.count)
        if inletCounter - counter == imagesData.count{
            return completion(.success(nil))
        }
    }
    func fetchDisplayImage(imagePath: String,completion:@escaping (Results<UIImage>) ->()) {
        storageRef.child(imagePath).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                completion(.error(error))
            } else {
                // Data for path is returned
                let image = UIImage(data: data!)
                completion(.success(image))
            }
        }
    }
    func fetchAllImages(imagesRef: [String],completion:@escaping (Results<[UIImage]>) ->()) {
        var images: [UIImage] = []
        var counter = 0
        
        imagesRef.forEach{ path in
            storageRef.child(path).getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    completion(.error(error))
                    counter += 1
                } else {
                    // Data for path is returned
                    if let image = UIImage(data: data!){
                        images.append(image)
                    }
                    counter += 1
                }
                if counter == imagesRef.count{
                    completion(.success(images))
                }
            }
        }
    }
    
    func deleteAlbum(_ id:String, imageRef: [String]) {
        imageRef.forEach({storageRef.child($0).delete()})
    }
    
}
