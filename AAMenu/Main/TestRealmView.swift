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
    
    var selectImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("IMAGE", for: .normal)
        btn.backgroundColor = .blue
        btn.titleLabel?.textColor = .white
        return btn
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
    
    var categoryListButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("CATEGORY", for: .normal)
        btn.backgroundColor = .blue
        btn.titleLabel?.textColor = .white
        return btn
        
    }()
    
    var dropView : UIView = {
       let view = UIView()
        
        return view
    }()
    
    var addButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("추가", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    var categoryText:UILabel = {
        let lb = UILabel()
        lb.textColor = .systemPink
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        return lb
    }()
    
    var menuImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        [selectImageButton,nameTextField,priceTextField,categoryListButton,dropView,categoryText,menuImage,addButton].forEach {
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
        
        selectImageButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(selectImageButton.snp.bottom).offset(20)
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
        
        categoryListButton.snp.makeConstraints{
            $0.top.equalTo(priceTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        dropView.snp.makeConstraints{
            $0.top.equalTo(categoryListButton.snp.bottom)
            $0.centerX.equalTo(categoryListButton.snp.centerX)
        }
        
        categoryText.snp.makeConstraints {
            $0.top.equalTo(dropView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(18)
            
        }
        
        menuImage.snp.makeConstraints{
            $0.top.equalTo(categoryText.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(30)
        }
    }
    
}
