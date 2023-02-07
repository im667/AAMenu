//
//  BasicPriceCell.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/04.
//

import UIKit

class BasicPriceCell: UITableViewCell {
    
    static let identifier = String(describing:BasicPriceCell.self)
    
    var data: PriceListType? {
        didSet {
            guard let data = data else { return }
            basicSettingLabel.text = data.priceType
        }
    }
    
    var basicSettingLabel : UILabel = {
       let label = UILabel()
        label.text = "test"
        label.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    var basicPriceTextField : UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
        tf.placeholder = "  price"
        return tf
    }()
    
    var settingTextStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    func setUI(){
        [basicSettingLabel,basicPriceTextField].forEach {
            settingTextStackView.addArrangedSubview($0)
        }
        [settingTextStackView].forEach { view in
            contentView.addSubview(view)
        }
        setConstraints()
        self.backgroundColor = .clear
    }
    
    func setConstraints(){
        basicSettingLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(72)
        }
        settingTextStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}


