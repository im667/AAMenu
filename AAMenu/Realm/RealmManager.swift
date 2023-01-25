//
//  RealmManager.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/21.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift
import RxRealm


public class RealmManager {
    
    static let shared = RealmManager()
    private var realm: Realm
    
    private init() {
        self.realm = try! Realm()
    }
    
    
    func addMenu(menuInfo: MenuData) {
        try! realm.write {
            realm.add(menuInfo)
        }
    }
    
    func deleteMenu(memuList: [MenuData]) {
        Observable.from(memuList)
            .subscribe(realm.rx.delete())
            .disposed(by: DisposeBag())
    }
    
    func getFilterMenu(category:[String])->Results<MenuData> {
        var menuList = realm.objects(MenuData.self)
        menuList = menuList
            .filter("category IN %@", category)
        
        return menuList
    }
    
    
}
