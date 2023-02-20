//
//  UserInputOptionCell.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class UserInputOptionCell:UITableViewCell {
    
    static let identifier = String(describing: UserInputOptionCell.self)
    
    var disposeBag = DisposeBag()
    var index : Int?
    
    var data: PriceListType? {
        didSet {
            userInputNameLabel.text = data?.name
            userInputPriceLabel.text = data?.price
        }
    }
   

    
    var delegate:UserInputPriceDelegate?
 
    
    var handleCellButton: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.setImage(UIImage(named: "option_remove_button"), for: .normal)
        return btn
    }()
    
    var userInputNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "test"
         return label
    }()

 
    var userInputPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "test"
         return label
    }()
    
    
    var settingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    @objc func removeCell(){
        guard let index = index else { return }
        delegate?.onRemove(index: index)
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
   
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        handleCellButton.addTarget(self, action: #selector(removeCell), for: .touchUpInside)
        [userInputNameLabel,userInputPriceLabel,handleCellButton].forEach {
            settingStackView.addArrangedSubview($0)
        }
        contentView.addSubview(settingStackView)
        setConstraints()
        self.backgroundColor = .clear
    }
    
    func setConstraints(){
        
        userInputNameLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(80)
        }
        
        userInputPriceLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(120)
        }
        
        handleCellButton.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        settingStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        
    }
    
  
}
