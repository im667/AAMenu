//
//  CategoryView.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/10.
//

import UIKit
import SnapKit

class CategoryView: BaseView {
    
    var categoryCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .darkGray
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        addSubview(categoryCollectionView)
    }
    
    override func setConstraints() {
        categoryCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}
