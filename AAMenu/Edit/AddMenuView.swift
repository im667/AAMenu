//
//  TestRealmView.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/15.
//

import UIKit
import SnapKit

class AddMenuView:BaseView {
    
    var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
        return scrollView
    }()
    
    var contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var defaultContainerView = UIView()
    
    var titleLabel : UILabel = {
       let label = UILabel()
        label.text = "메뉴를 추가합니다.(다국어)"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "메뉴이름(다국어)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    var nameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
        tf.placeholder = "  리스트 타이틀(다국어)"
        return tf
    }()
    
    var selectImageLabel: UILabel = {
        let label = UILabel()
        label.text = "대표 사진(다국어)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()

    var selectImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("선택", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.systemGray4, for: .normal)
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    var priceLabel: UILabel = {
       let label = UILabel()
        label.text = "대표 가격 설정(다국어)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    var priceTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
        tf.placeholder = "  1000원"
        return tf
    }()
    
    var categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "카테고리 설정(다국어)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
   
    var categoryListButton: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.darkGray, for: .normal)
        btn.layer.cornerRadius = 8
        btn.setTitle("선택", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
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
    
    var optionSwitch: Bool? {
        didSet {
            guard let optionSwitch = optionSwitch else { return }
              setOptionPriceContainer(isOn: optionSwitch)
        }
    }
    
    func setOptionPriceContainer(isOn:Bool) {
        if isOn {
            priceSettingStackView.snp.updateConstraints {
                $0.height.equalTo(40)
            }
            basicPriceContainer.snp.updateConstraints {
                $0.height.equalTo(200)
            }
          
            offOptionButton.setImage(UIImage(named: "radio_Off"), for: .normal)
            onOptionButton.setImage(UIImage(named: "radio_On"), for: .normal )
        } else {
            priceSettingStackView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            basicPriceContainer.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            userInputPriceContainer.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            offOptionButton.setImage(UIImage(named: "radio_On"), for: .normal )
            onOptionButton.setImage(UIImage(named: "radio_Off"), for: .normal)
        }
        basicPriceContainer.isHidden = !isOn
        priceSettingStackView.isHidden = !isOn
        selectSettingButton.isHidden = !isOn
       
    }
    
    var priceSwitch: Bool = true {
        didSet {
            setPriceSwitch(isOn: priceSwitch)
        }
    }
    
    func setPriceSwitch(isOn:Bool){
        if isOn {
            //기본 설정
            basicPriceSettingButton.backgroundColor = .primaryColor
            userInputPriceSettingButton.backgroundColor = .darkGray
           
            userInputPriceContainer.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            
        } else {
            //직접 입력
            
            basicPriceSettingButton.backgroundColor = .darkGray
            userInputPriceSettingButton.backgroundColor = .primaryColor
            userInputPriceContainer.snp.updateConstraints {
                $0.height.equalTo(280)
            }
       
        }
        basicPriceContainer.isHidden = !isOn
        userInputPriceContainer.isHidden = isOn
        addPriceView.isHidden = isOn
    }
    
    
    var offOptionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "radio_On"), for: .normal)
        return btn
    }()
    
    var offOptionLabel: UILabel = {
       let label = UILabel()
        label.text = "옵션 가격을 설정하지 않습니다.(다국어)"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    var offOptionTouchArea: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    var onOptionButton:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "radio_Off"), for: .normal)
        return btn
    }()
    
    var onOptionLabel:UILabel = {
       let label = UILabel()
        label.text = "옵션 가격 설정.(다국어)"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    var onOptionTouchArea: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
  
    
    var priceSettingStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.axis = .horizontal
        return stackView
    }()
    
    var basicPriceSettingButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .primaryColor
        btn.setTitle("기본 설정", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    var userInputPriceSettingButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .darkGray
        btn.setTitle("직접 입력", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    var basicPriceContainer: UIView = {
       let view = UIView()
        return view
    }()
    
    var basicSettingStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.alignment = .top
        return stackView
    }()
    
    var selectSettingButton: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .white
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        btn.setTitle("선택", for: .normal)
        return btn
    }()
    
    var basicPriceDropView: UIView = {
        let view = UIView()
        return view
    }()
    
    var basicPriceTableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    
    var userInputPriceContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var addPriceView: PriceAddCustomView = {
       let view = PriceAddCustomView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    var userInputPriceTableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        return tableView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        
        [nameLabel,nameTextField,selectImageLabel,selectImageButton,priceLabel,priceTextField,categoryLabel,categoryListButton,dropView].forEach {
            defaultContainerView.addSubview($0)
        }
        
        [offOptionButton,offOptionLabel].forEach {
            offOptionTouchArea.addArrangedSubview($0)
        }
        
        [onOptionButton,onOptionLabel].forEach {
            onOptionTouchArea.addArrangedSubview($0)
        }
        
        [basicPriceSettingButton,userInputPriceSettingButton].forEach {
            priceSettingStackView.addArrangedSubview($0)
        }
        
        [basicPriceDropView,selectSettingButton,basicPriceTableView].forEach {
            basicPriceContainer.addSubview($0)
        }
        
        [addPriceView,userInputPriceTableView].forEach {
            userInputPriceContainer.addSubview($0)
        }
        
        [titleLabel,defaultContainerView,offOptionTouchArea,onOptionTouchArea,priceSettingStackView,basicPriceContainer,userInputPriceContainer,addButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
    }
    
    override func setConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        defaultContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(72)
            $0.width.equalTo(408)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(288)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        nameTextField.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.height.equalTo(36)
            $0.width.equalTo(180)
            $0.trailing.equalToSuperview()
        }
        
        selectImageLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        selectImageButton.snp.makeConstraints {
            $0.top.equalTo(selectImageLabel.snp.top)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(selectImageButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.top)
            $0.height.equalTo(28)
            $0.width.equalTo(148)
            $0.trailing.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(priceTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        categoryListButton.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.top)
            $0.height.equalTo(28)
            $0.width.equalTo(148)
            $0.trailing.equalToSuperview()
        }
        
        dropView.snp.makeConstraints{
            $0.top.equalTo(categoryListButton.snp.bottom)
            $0.centerX.equalTo(categoryListButton.snp.centerX)
        }
        offOptionButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
        
        onOptionButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
        
        offOptionTouchArea.snp.makeConstraints {
            $0.top.equalTo(defaultContainerView.snp.bottom).offset(52)
            $0.leading.equalTo(defaultContainerView.snp.leading)
            $0.trailing.equalTo(defaultContainerView.snp.trailing)
            $0.height.equalTo(32)
        }
        
        onOptionTouchArea.snp.makeConstraints {
            $0.top.equalTo(offOptionTouchArea.snp.bottom).offset(24)
            $0.leading.equalTo(defaultContainerView.snp.leading)
            $0.trailing.equalTo(defaultContainerView.snp.trailing)
            $0.height.equalTo(32)
        }
        
        basicPriceSettingButton.snp.makeConstraints {
            $0.width.equalTo(userInputPriceSettingButton.snp.width)
            $0.height.equalTo(40)
        }
        
        userInputPriceSettingButton.snp.makeConstraints {
            $0.width.equalTo(basicPriceSettingButton.snp.width)
            $0.height.equalTo(40)
        }
        
        priceSettingStackView.snp.makeConstraints {
            $0.top.equalTo(onOptionTouchArea.snp.bottom).offset(48)
            $0.leading.trailing.equalTo(defaultContainerView).inset(24)
            $0.height.equalTo(40)
        }
        
        basicPriceContainer.snp.makeConstraints {
            $0.top.equalTo(priceSettingStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(defaultContainerView).inset(40)
            $0.height.equalTo(0)
        }
        
        userInputPriceContainer.snp.makeConstraints {
            $0.top.equalTo(priceSettingStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(defaultContainerView).inset(40)
            $0.height.equalTo(0)
        }
        
        addPriceView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        userInputPriceTableView.snp.makeConstraints {
            $0.top.equalTo(addPriceView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        selectSettingButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(72)
        }
        
        basicPriceDropView.snp.makeConstraints {
            $0.top.equalTo(selectSettingButton.snp.bottom)
            $0.centerX.equalTo(selectSettingButton.snp.centerX)
        }
        
      
        basicPriceTableView.snp.makeConstraints {
            $0.leading.equalTo(selectSettingButton.snp.trailing).offset(16)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(basicPriceContainer.snp.bottom).offset(52)
            $0.bottom.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(30)
        }
    }
    
}
