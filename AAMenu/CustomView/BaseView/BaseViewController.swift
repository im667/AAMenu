//
//  BaseViewController.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/19.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class BaseViewController:UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    func showToast(message: String, duration: TimeInterval = 1.0) {
        view.makeToast(message, duration: duration, position: .bottom)
    }
    
    func showCenterToast(message: String, duration: TimeInterval = 1.0) {
        var style = ToastStyle()
                
        style.messageFont = .systemFont(ofSize: 12, weight: .medium)
        style.messageColor = .lightText
        style.messageAlignment = .center
 
        style.backgroundColor = .darkGray
        style.cornerRadius = 12
        style.horizontalPadding = 70
        style.verticalPadding = 70
        
        style.displayShadow = true
        style.shadowColor = .black
        style.shadowOpacity = 0.3
        style.shadowRadius = 8
        style.shadowOffset = CGSize(width: 0, height: 3)
        
        view.makeToast(message, duration: duration, position: .center, style: style)
    }
}
