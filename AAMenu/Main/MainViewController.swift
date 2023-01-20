//
//  ViewController.swift
//  AAMenu
//
//  Created by 권오현 on 2022/11/30.
//

import UIKit
import RxSwift
import RxCocoa


struct CategoryData: Codable {
    var name: String
}




class MainViewController: UIViewController {
    
    var mainView = MainView()
    var dataSource = [CategoryData]()
 
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setCategoryMokData()
        mainView.backgroundColor = .white
        mainView.button.addTarget(self, action: #selector(openTestAlert), for: .touchUpInside)
    }
    
    @objc func openTestAlert(){
        let vc = TestRealmAlert()
        
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func setCategoryMokData(){
        dataSource = [
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee"),
            CategoryData(name: "coffee")
        ]
    }
    func setCollectionView(){
        mainView.category.categoryCollectionView.delegate = self
        mainView.category.categoryCollectionView.dataSource = self
        mainView.category.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        mainView.menuList.mainCollectionView.dataSource = self
        mainView.menuList.mainCollectionView.delegate = self
        mainView.menuList.mainCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
    }
    
    

}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let mainCV = mainView.menuList.mainCollectionView
        let cateCV = mainView.category.categoryCollectionView
        
        if collectionView == mainCV {
            return 1
        }
        
        if collectionView == cateCV {
            return dataSource.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCV = mainView.menuList.mainCollectionView
        let cateCV = mainView.category.categoryCollectionView
        
        if collectionView == mainCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
            cell.backgroundColor = .blue
            cell.menuName.text = "sdf"
            return cell
            
        }
        
        if collectionView == cateCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            cell.categoryName.text = self.dataSource[indexPath.item].name
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainCV = mainView.menuList.mainCollectionView
        let cateCV = mainView.category.categoryCollectionView
        
        if collectionView == mainCV {
            let cell = collectionView.cellForItem(at: indexPath)
            
        }
        
        if collectionView == cateCV {
            let cell = collectionView.cellForItem(at: indexPath)
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
}

