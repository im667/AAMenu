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
    
    var menuName: UILabel = {
       let lb = UILabel()
        lb.font = .systemFont(ofSize: 52, weight: .regular)
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
        contentView.addSubview(menuName)
        setConstraints()
    }
    
    func setConstraints(){
        menuName.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
            
        }
    }
    
}


