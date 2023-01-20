//
//  categoryCell.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/10.
//

import UIKit
import SnapKit

class CategoryCell:UICollectionViewCell {
    
    static let identifier = String(describing:CategoryCell.self)
    
    var categoryName: UILabel = {
       let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 20, weight: .bold)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryName)
        
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setConstraints(){
        categoryName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }
    }
}
