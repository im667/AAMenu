//
//  MenuData.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/14.
//

import UIKit
import RealmSwift
import Photos
 
class MenuData: Object {
    @Persisted var menuName = ""
    @Persisted var price = ""
    @Persisted var isHot = false
    @Persisted var category = ""
    @Persisted var menuDatail : List<MenuDetailData>
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(menuName: String, price: String, isHot: Bool,category:String, _id: ObjectId) {
        self.init()
        
        self.menuName = menuName
        self.price = price
        self.isHot = isHot
        self.category = category

        self.menuDatail.append(objectsIn: menuDatail)
    }
}


class MenuDetailData: Object {
    
    @Persisted var menuInfo = ""
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(menuInfo: String) {
        self.init()
        self.menuInfo = menuInfo
    }
}
