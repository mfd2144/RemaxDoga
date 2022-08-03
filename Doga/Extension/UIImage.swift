//
//  UIImage.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 2.07.2022.
//

import Foundation
import UIKit

extension UIImage {
    func convertData() -> Data? {
        var roughSize = 1
            if  let represtation = (self).jpegData(compressionQuality: 1) {
                let imgData: NSData = NSData(data:represtation)
                let sizeInBytes = imgData.count
                roughSize = Int(sizeInBytes / 1_000_000)
                return self.jpegData(compressionQuality: 1/Double(roughSize))
            } else {
                return nil
            }
      }
}
