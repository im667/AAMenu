//
//  UserDefaults.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/23.
//

import UIKit

class UserDefaultManager {
    @UserDefault(key: "categoryList", defaultValue: [String]())
    static var categoryList: [String]
}


@propertyWrapper
struct UserDefault<T> {
    private let ud = UserDefaults.standard
    private let key : String
    
    private var defaultValue : T
    
    var wrappedValue : T {
        get {
            return ud.value(forKey: key) as? T ?? defaultValue
        }
        set {
            ud.setValue(newValue, forKey: key)
        }
    }
    
    init(key : String, defaultValue : T){
        self.key = key
        self.defaultValue = defaultValue
    }
}
