//
//  TestRealmView.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/15.
//

import UIKit
import SnapKit

class TestRealmView:BaseView {
    
    var container: UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var nameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.white.cgColor
        tf.placeholder = "메뉴이름"
        
        return tf
    }()
    
    var priceTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.white.cgColor
        tf.placeholder = "가격"
        
        return tf
    }()
    
    var addButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("추가", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        [nameTextField,priceTextField,addButton].forEach {
            container.addSubview($0)
        }
        self.addSubview(container)
    }
    
    override func setConstraints() {
        
        container.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(30)
        }
    }
    
}
