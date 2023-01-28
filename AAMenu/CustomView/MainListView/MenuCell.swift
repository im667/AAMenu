//
//  MainCell.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/10.
//

import UIKit
import SnapKit

class MenuCell:UICollectionViewCell {
    
    static let identifier = String(describing:MenuCell.self)
    
    var data: MenuData? {
        didSet {
            guard let data = data else { return }
            menuName.text = data.menuName
            print("MENUNAME:",data.menuName)
            price.text = data.price
            category.text = data.category
           
        }
    }
    
    var imageView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    
    var menuName: UILabel = {
       let lb = UILabel()
        lb.font = .systemFont(ofSize: 10, weight: .regular)
        lb.textColor = .white
        return lb
    }()
    
    var price: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 10, weight: .regular)
        lb.textColor = .white
        return lb
    }()
    
    var category : UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 10, weight: .regular)
        lb.textColor = .white
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        [imageView,menuName,price,category].forEach { view in
            self.addSubview(view)
        }
        setConstraints()
    }
    
    func setConstraints(){
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(150)
            $0.width.equalTo(150)
        }
        menuName.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        price.snp.makeConstraints {
            $0.top.equalTo(menuName.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            
        }
        category.snp.makeConstraints {
            $0.top.equalTo(price.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            
        }
    }
    
}


