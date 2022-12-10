//
//  MainView.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/10.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    var category = CategoryView()
    var menuList = MenuListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        [category,menuList].forEach { view in
            self.addSubview(view)
        }
    }
    
    override func setConstraints() {
        category.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        menuList.snp.makeConstraints {
            $0.top.equalTo(category.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            
        }
    }

}
