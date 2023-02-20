//
//  PriceAddCustomView.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PriceAddCustomView:BaseView,UITextFieldDelegate {
    
    var keyboardDelegate: KeyBoardShowHideDelegate?
    let disposeBag = DisposeBag()
    
    var delegate:UserInputPriceDelegate?
 
    var name = String()
    var price = String()
    
    var userInputNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "  title"
         return textField
    }()
    
    var userInputPriceTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "  price"
         return textField
    }()
    
    var addButton: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.setImage(UIImage(named: "option_add_button"), for: .normal)
        return btn
    }()
    
    var settingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    @objc func addCell(){
        delegate?.onAdd(name: name, price: price)
        [userInputNameTextField,userInputPriceTextField].forEach { tf in
            tf.text = ""
        }
        name = ""
        price = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userInputNameTextField.rx.controlEvent([.editingDidBegin]).subscribe{ _ in
            self.keyboardDelegate?.keyboardShowUpdateView()
        }.disposed(by: self.disposeBag)
        
        userInputNameTextField.rx.controlEvent([.editingDidEnd]).subscribe{ _ in
            self.keyboardDelegate?.keyboardHideUpdateView()
        }.disposed(by: self.disposeBag)
        
        userInputPriceTextField.rx.controlEvent([.editingDidBegin]).subscribe{ _ in
            self.keyboardDelegate?.keyboardShowUpdateView()
        }.disposed(by: self.disposeBag)
        
        userInputPriceTextField.rx.controlEvent([.editingDidEnd]).subscribe{ _ in
            self.keyboardDelegate?.keyboardHideUpdateView()
        }.disposed(by: self.disposeBag)
      
    }
    
    override func setUI() {
        
        [userInputNameTextField,userInputPriceTextField,addButton].forEach { view in
            settingStackView.addArrangedSubview(view)
        }
        self.addSubview(settingStackView)
        userInputPriceTextField.delegate = self
        userInputNameTextField.delegate = self
        addButton.addTarget(self, action: #selector(addCell), for: .touchUpInside)
    }
    
    override func setConstraints() {
        userInputNameTextField.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(userInputPriceTextField.snp.width)
        }
        
        userInputPriceTextField.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(userInputNameTextField.snp.width)
        }
        
        addButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
        
        settingStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userInputPriceTextField {
            self.price = textField.text ?? ""
        } else {
            self.name = textField.text ?? ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userInputPriceTextField {
            self.price = textField.text ?? ""
            textField.resignFirstResponder()
            addCell()
        } else {
            self.name = textField.text ?? ""
            textField.resignFirstResponder()
            userInputPriceTextField.becomeFirstResponder()
        }
    
        return true
    }

}
