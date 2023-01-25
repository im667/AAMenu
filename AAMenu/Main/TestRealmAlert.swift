//
//  CustomAddAlert.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/15.
//

import UIKit
import RealmSwift
import DropDown
import AVFoundation
import Photos

class TestRealmAlert: UIViewController {
    
    let mainView = TestRealmView()
    let dropDown = DropDown()
    let imagePicker = UIImagePickerController()
    var imagePath = ""
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.borderColor = UIColor.white.cgColor
        mainView.layer.borderWidth = 3
        
        mainView.addButton.addTarget(self, action: #selector(addRealm), for: .touchUpInside)
        mainView.categoryListButton.addTarget(self, action: #selector(setDrop), for: .touchUpInside)
        mainView.selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        dropinit()
        
        imagePicker.delegate = self
    }
    
    @objc func setDrop(){
        dropDown.show()
    }
    
    func dropinit(){
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        dropDown.dataSource = CategoryManager.shared.getCategory()
        dropDown.anchorView = mainView.dropView
        dropDown.bottomOffset = CGPoint(x: 0, y: mainView.dropView.bounds.height)
        dropDown.selectionAction = { [weak self] (index, item) in
              //선택한 Item을 TextField에 넣어준다.
            self!.mainView.categoryText.text = item
          }
    }
    
    @objc func addRealm(){
        let object = MenuData()
        object.menuName = mainView.nameTextField.text!
        object.price = mainView.priceTextField.text!
        object.category = mainView.categoryText.text!
        saveImageToDocumentDirectory(imageName: "\(object._id).png", image: mainView.menuImage.image!)
        RealmManager.shared.addMenu(menuInfo: object)
        let realm = try!Realm()
        print(realm.objects(MenuData.self).count)
    
    }
    
    
    
    @objc func selectImage(){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
            // 1. 이미지를 저장할 경로를 설정해줘야함 - 도큐먼트 폴더,File 관련된건 Filemanager가 관리함(싱글톤 패턴)
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            
            // 2. 이미지 파일 이름 & 최종 경로 설정
            let imageURL = documentDirectory.appendingPathComponent(imageName)
            
            // 3. 이미지 압축(image.pngData())
            // 압축할거면 jpegData로~(0~1 사이 값)
            guard let data = image.pngData() else {
                print("압축이 실패했습니다.")
                return
            }
            
            // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기하는 경우
            // 4-1. 이미지 경로 여부 확인
            if FileManager.default.fileExists(atPath: imageURL.path) {
                // 4-2. 이미지가 존재한다면 기존 경로에 있는 이미지 삭제
                do {
                    try FileManager.default.removeItem(at: imageURL)
                    print("이미지 삭제 완료")
                } catch {
                    print("이미지를 삭제하지 못했습니다.")
                }
            }
            
            // 5. 이미지를 도큐먼트에 저장
            // 파일을 저장하는 등의 행위는 조심스러워야하기 때문에 do try catch 문을 사용하는 편임
            do {
                try data.write(to: imageURL)
                print("이미지 저장완료")
            } catch {
                print("이미지를 저장하지 못했습니다.")
            }
        }
    
}


extension TestRealmAlert: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL {
            let imagePath = imageURL.absoluteString
            self.imagePath = imagePath
            let data = try? Data(contentsOf: imageURL)
            if let imageData = data {
                mainView.menuImage.image = UIImage(data: imageData)
            }
            
        }
        
        dismiss(animated: true)
    }
    
    
}
