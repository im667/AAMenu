//
//  MainListView.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/10.
//

import UIKit
import SnapKit

class MenuListView: BaseView {
    
    var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setUI() {
        addSubview(mainCollectionView)
    }
    
    override func setConstraints() {
        mainCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
