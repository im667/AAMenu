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
    var viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        mainView.backgroundColor = .white
        mainView.button.addTarget(self, action: #selector(openTestAlert), for: .touchUpInside)
     
        DispatchQueue.main.async {
            self.setCategoryData()
            self.viewModel.input.filterType.accept(["coffee"])
            self.setCollectionView()
            self.rxBind()
        }
       
    }
    
    @objc func openTestAlert(){
        let vc = TestRealmAlert()
        
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func rxBind(){
      
        viewModel.output.menuList
            .asObservable()
            .subscribe(onNext: {
                print($0.count)
                if $0.isEmpty {
                    print("Empty")
                } else {
                    print("USALBE PAGE")
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.output.menuList
            .bind(to: mainView.menuList.mainCollectionView.rx.items(
                cellIdentifier: MenuCell.identifier)) {
                    (index, data, cell) in
                    guard let cell : MenuCell = cell as? MenuCell else { return }
                    cell.data = data
                    cell.imageView.image = self.loadImageFromDocumentDirectory(imageName: "\(data._id).png")
                }
                .disposed(by: disposeBag)
        
        mainView.menuList.mainCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
        let mainCV = mainView.menuList.mainCollectionView
   
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
           
            let filterItem = self.dataSource[indexPath.row]
            var filter = [String]()
            filter.append(filterItem)
            viewModel.input.filterType.accept(filter)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            mainCV.reloadData()
        }
    }
    
    
}

