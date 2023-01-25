//
//  ViewController.swift
//  AAMenu
//
//  Created by 권오현 on 2022/11/30.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift


class MainViewController: UIViewController {
    
    var mainView = MainView()
    var dataSource = [String]()
    var menuData: Results<MenuData>!
    var viewModel = MainViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setMenuData()
        setCategoryData()
        mainView.backgroundColor = .white
        mainView.button.addTarget(self, action: #selector(openTestAlert), for: .touchUpInside)
        viewModel.input.filterType.accept(["coffee"])
        rxBind()
    }
    
    @objc func openTestAlert(){
        let vc = TestRealmAlert()
        
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func rxBind(){
        mainView.menuList.mainCollectionView.rx.setDelegate(self).disposed(by: DisposeBag())
        viewModel.output.menuList
            .subscribe(onNext: {
                if $0.isEmpty {
                    print("Empty")
                } else {
                    print("USE PAGE")
                }
            })
            .disposed(by: DisposeBag())
        
        viewModel.output.menuList
            .asObservable()
            .bind(to: mainView.menuList.mainCollectionView.rx.items) { [weak self] (cv, row, items) in
                let cell : MenuCell = cv.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: IndexPath(row: row, section: 0)) as! MenuCell
                cell.data = items
                cell.menuName.text = items.menuName
                cell.price.text = items.price
                cell.category.text = items.category
                cell.imageView.image = self!.loadImageFromDocumentDirectory(imageName: "\(items._id).png")
                
                return cell
            }
            .disposed(by: DisposeBag())
    }
    
    func setMenuData(){
        menuData = try!Realm().objects(MenuData.self)
    }
    
    func setCategoryData(){
        dataSource = CategoryManager.shared.getCategory()
    }
    
    func setCollectionView(){
        mainView.category.categoryCollectionView.delegate = self
        mainView.category.categoryCollectionView.dataSource = self
        mainView.category.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
   
        mainView.menuList.mainCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
           
           // 1. 도큐먼트 폴더 경로가져오기
           let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
           let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
           let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
           
           if let directoryPath = path.first {
           // 2. 이미지 URL 찾기
               let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
               // 3. UIImage로 불러오기
               return UIImage(contentsOfFile: imageURL.path)
           }
           
           return nil
       }
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cateCV = mainView.category.categoryCollectionView
   
        if collectionView == cateCV {
            return dataSource.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cateCV = mainView.category.categoryCollectionView
        
        
        if collectionView == cateCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            cell.categoryName.text = self.dataSource[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainCV = mainView.menuList.mainCollectionView
        let cateCV = mainView.category.categoryCollectionView
  
        
        if collectionView == cateCV {
            let cell = collectionView.cellForItem(at: indexPath)
            let filter = self.dataSource[indexPath.row]
            
            viewModel.input.filterType.accept([filter])
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            mainCV.reloadData()
        }
    }
    
    
}

