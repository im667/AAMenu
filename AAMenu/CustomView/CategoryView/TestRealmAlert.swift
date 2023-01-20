//
//  CustomAddAlert.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/15.
//

import UIKit
import RealmSwift

class TestRealmAlert: UIViewController {
    
    let mainView = TestRealmView()
 
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.borderColor = UIColor.white.cgColor
        mainView.layer.borderWidth = 3
        
        mainView.addButton.addTarget(self, action: #selector(addRealm), for: .touchUpInside)
        
        
    }
    
    @objc func addRealm(){
        var object = MenuData()
        object.menuName = mainView.nameTextField.text!
        object.price = mainView.priceTextField.text!
  
        RealmManager.shared.addMenu(menuInfo: object)
        let realm = try!Realm()
        print(realm.objects(MenuData.self).count)
    }
    
}
