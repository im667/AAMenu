//
//  ViewController.swift
//  AAMenu
//
//  Created by 권오현 on 2022/11/30.
//

import UIKit

class MainViewController: UIViewController {
    
    var mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
        
    }


}

