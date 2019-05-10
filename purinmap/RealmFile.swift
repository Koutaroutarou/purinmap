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
    
    @objc dynamic var imageData = Data()
    
    @objc dynamic var shopLatitude: Double = 0.0
    
    @objc dynamic var shopLongitude: Double = 0.0
}
