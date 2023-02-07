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
    
    var button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setTitle("추가", for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        [category,menuList,button].forEach { view in
            self.addSubview(view)
        }
     
    }
    
    override func setConstraints() {
        category.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        menuList.snp.makeConstraints {
            $0.top.equalTo(category.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            
        }
        button.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
    }

}
