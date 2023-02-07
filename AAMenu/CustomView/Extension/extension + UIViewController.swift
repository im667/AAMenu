//
//  extension + UIViewController.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/02.
//

import UIKit

extension UIViewController {
    func viewTouchHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
