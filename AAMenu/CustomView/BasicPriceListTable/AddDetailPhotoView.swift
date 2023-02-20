//
//  AddDetailPhotoView.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/19.
//

import UIKit
import SnapKit


class DetailPhotoCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailPhotoCell.self)
    
    var photo: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var removeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        
    }
    
    func setConstraints(){
        
    }
    
}

class AddDetailPhotoView: BaseView {
    
    var title: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    var info: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    var addbutton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
}
