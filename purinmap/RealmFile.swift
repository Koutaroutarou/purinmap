//
//  RealmFile.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/05/09.
//  Copyright © 2019 litech. All rights reserved.
//

import Foundation
import RealmSwift

class PuddingList: Object {
    
    @objc dynamic var shopName: String = ""
    
    @objc dynamic var commnet: String = ""
    
    @objc dynamic var review: String = ""
    
    @objc dynamic var reviewStarRealm: String = ""
    
    @objc dynamic var shopLatitude: Double = 0.0
    
    @objc dynamic var shopLongitude: Double = 0.0
    
//    @objc dynamic private var _purinImage: UIImage? = nil
//
//    @objc dynamic var purinImage: UIImage? {
//        set {
//            self._purinImage = newValue
//            if let value = newValue {
//                self.purinImageData = value.jpegData(compressionQuality: 1)
//            }
//        }
//        get {
//            if let image = self._purinImage {
//                return image
//            }
//
//            if let data = self.purinImageData {
//                self._purinImage = UIImage(data: data)
//                return self._purinImage
//            }
//
//            return nil
//        }
//    }
//
//    @objc dynamic private var purinImageData: Data? = nil
//
//    override static func ignoredProperties() -> [String] {
//        return ["_purinImage", "purinImage"]
//    }
}
