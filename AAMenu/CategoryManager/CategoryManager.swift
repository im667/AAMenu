//
//  CategoryManager.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/23.
//

import Foundation

class CategoryManager {
    
    static let shared = CategoryManager()
    init(){}
    
    var defaultCategoryList : [String] {
        return ["coffee","dessert","etc"]
    }
  
    func setCategory(categoryList:[String]){
        UserDefaultManager.categoryList = categoryList
        
    }
    
    func getCategory()->[String]{
        var list : [String] = []
        
        UserDefaultManager.categoryList.forEach { i in
            list.append(i)
        }
        
        if list.isEmpty {
            list = defaultCategoryList
        }
        
        return list
    }
}
