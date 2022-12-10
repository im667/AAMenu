//
//  CustomView.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/10.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setView(){
        setUI()
        setConstraints()
    }
    
    func setUI(){ }
    func setConstraints(){ }
    
}
