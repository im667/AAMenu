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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
