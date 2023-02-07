//
//  UserInputOptionCell.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/05.
//

import UIKit
import SnapKit

class UserInputOptionCell:UITableViewCell {
    
    static let identifier = String(describing: UserInputOptionCell.self)
    
    var userInputNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "  Option Name"
         return textField
    }()
    
    var userInputPriceTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "  Option Price"
         return textField
    }()
    
    var removeButton: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.setImage(UIImage(named: "option_remove_button"), for: .normal)
        return btn
    }()
    
    var settingStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        
        [userInputNameTextField,userInputPriceTextField,removeButton].forEach {
            settingStackView.addSubview($0)
        }
        contentView.addSubview(settingStackView)
        setConstraints()
        self.backgroundColor = .clear
    }
    
    func setConstraints(){
        userInputNameTextField.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(80)
        }
        
        userInputPriceTextField.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(120)
        }
        
        removeButton.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        settingStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        
    }
    
  
}
