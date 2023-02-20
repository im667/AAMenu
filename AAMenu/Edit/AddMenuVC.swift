//
//  CustomAddAlert.swift
//  AAMenu
//
//  Created by 권오현 on 2023/01/15.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard
import RealmSwift
import DropDown
import AVFoundation
import Photos

protocol UserInputPriceDelegate {
    func onAdd(name:String,price:String)
    func onRemove(index:Int)
}

protocol KeyBoardShowHideDelegate{
    func keyboardShowUpdateView()
    func keyboardHideUpdateView()
}

enum OptionMode {
    case basic
    case userInput
}

extension AddMenuVC: UserInputPriceDelegate {
    
    func onAdd(name: String, price: String) {
        if name.isEmpty || price.isEmpty {
            showToast(message: "이름과 가격 모두 입력해주세요.(다국어)")
            return
        }
        
        if userInputPriceList.count < 5 {
            userInputPriceList.append(PriceListType(name: name, price: price))
            userInputPriceViewModel.input.userInputList.accept(userInputPriceList)
            return
        } else {
            showToast(message: "5개 이상 입력할 수 없습니다.(다국어)")
            return
        }
    }
    
    func onRemove(index:Int) {
        print("remove")
        userInputPriceList.remove(at: index)
        userInputPriceViewModel.input.userInputList.accept(userInputPriceList)
    }
}

class AddMenuVC: BaseViewController, UIScrollViewDelegate {
    
    let mainView = AddMenuView()
    let categoryDropDown = DropDown()
    let basicPriceDropDwon = DropDown()
    let imagePicker = UIImagePickerController()
    var imagePath = ""
    var basicPriceDefault = [String]()
    var basicPriceViewModel = BasicPriceViewModel()
    var userInputPriceViewModel = UserInputPriceViewModel()
    var categoryItem = String()
    var selectedBasicPrice = String()

    var optionMode: OptionMode = .basic
    
    var isBasicPrice : Bool = true {
        didSet {
            mainView.priceSwitch = isBasicPrice
        }
    }
    var isOptionPrice : Bool? {
        didSet {
            guard let isOptionPrice = isOptionPrice else { return }
            mainView.optionSwitch = isOptionPrice
        }
    }
    
    var userInputPriceList : [PriceListType] = []
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        DispatchQueue.main.async {
            self.setRx()
        }
        
        setDropData()
      
        self.viewTouchHideKeyboard()
    }

    
    
    @objc func setCategoryDrop(){
        categoryDropDown.show()
    }
    
    @objc func setBasicPriceDrop(){
        basicPriceDropDwon.show()
    }
    
    func setView(){
        let category = CategoryManager.shared.getCategory()
        categoryItem = category.first!
        mainView.categoryListButton.setTitle(categoryItem, for: .normal)
        
        mainView.addButton.addTarget(self, action: #selector(addRealm), for: .touchUpInside)
        mainView.categoryListButton.addTarget(self, action: #selector(setCategoryDrop), for: .touchUpInside)
        mainView.selectSettingButton.addTarget(self, action: #selector(setBasicPriceDrop), for: .touchUpInside)
        mainView.selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        mainView.basicPriceSettingButton.addTarget(self, action: #selector(onBasicPrice), for: .touchUpInside)
        mainView.userInputPriceSettingButton.addTarget(self, action: #selector(onUserInputPrice), for: .touchUpInside)
        
        let onTapGesture = UITapGestureRecognizer(target: self, action: #selector(onOption))
        mainView.onOptionTouchArea.addGestureRecognizer(onTapGesture)
        let offTapGesture = UITapGestureRecognizer(target: self, action: #selector(offOption))
        mainView.offOptionTouchArea.addGestureRecognizer(offTapGesture)
          
        mainView.optionSwitch = false
        mainView.basicPriceTableView.register(BasicPriceCell.self, forCellReuseIdentifier: BasicPriceCell.identifier)
        mainView.basicPriceTableView.isHidden = true
        
        mainView.userInputPriceTableView.register(UserInputOptionCell.self, forCellReuseIdentifier: UserInputOptionCell.identifier)
        mainView.userInputPriceTableView.isHidden = true
        imagePicker.delegate = self
        mainView.addPriceView.delegate = self
        mainView.addPriceView.keyboardDelegate = self
        
       
    }
    
    func setDropData(){
        basicPriceDefault = BasicPriceType.allCasesTypeName()
        dropinit()
    }
    
    
    func setRx(){

        mainView.basicPriceTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        mainView.userInputPriceTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        basicPriceViewModel.output.priceList
            .asObservable()
            .bind(to: mainView.basicPriceTableView.rx.items)  { [weak self] (tv, row, item) in
                let cell: BasicPriceCell = tv.dequeueReusableCell(withIdentifier: BasicPriceCell.identifier, for: IndexPath(row: row, section: 0)) as! BasicPriceCell
                
                cell.data = item
                cell.selectionStyle = .none
                
                cell.basicPriceTextField.rx.controlEvent([.editingDidBegin]).subscribe{ _ in
                self?.mainView.addButton.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-500)
                    }
                }.disposed(by: self!.disposeBag)
                
                cell.basicPriceTextField.rx.controlEvent([.editingDidEnd]).subscribe{ _ in
                self?.mainView.addButton.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-52)
                }
                }.disposed(by: self!.disposeBag)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        // 마지막 셀 컨트롤
        //            .map { prices in
        //                    let prices = prices + [PriceListType(name: "", price: "")]
        //                return prices.enumerated().map { (index, price) in (price, index == prices.count - 1) }
        //                }

        userInputPriceViewModel.output.priceList
            .bind(to: mainView.userInputPriceTableView.rx.items) { [weak self](tv, row, element) in
                let cell: UserInputOptionCell = tv.dequeueReusableCell(withIdentifier: UserInputOptionCell.identifier, for: IndexPath(row: row, section: 0)) as! UserInputOptionCell
              
                cell.index = row
                cell.data = element
                cell.handleCellButton.setImage(UIImage(named: "option_remove_button"), for: .normal)
                cell.delegate = self
                cell.selectionStyle = .none
                    return cell
                }
            .disposed(by: disposeBag)
    }
    
    @objc func onBasicPrice(){
        isBasicPrice = true
        optionMode = .basic
    }
    
    @objc func onUserInputPrice(){
        isBasicPrice = false
        mainView.userInputPriceTableView.isHidden = false
        optionMode = .userInput
    }
    
    @objc func offOption(){
        print("OFF")
        isOptionPrice = false
        resetOptionPrice()
    }
    
    @objc func onOption(){
        print("ON")
        isOptionPrice = true
    }
    
    func resetOptionPrice(){
        isBasicPrice = true
    }
    
    func dropinit(){
        DropDown.appearance().textColor = UIColor.darkGray // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.darkGray // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        categoryDropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        categoryDropDown.dataSource = CategoryManager.shared.getCategory()
        categoryDropDown.anchorView = mainView.dropView
        categoryDropDown.bottomOffset = CGPoint(x: 0, y: mainView.dropView.bounds.height)
        categoryDropDown.selectionAction = { [weak self] (index, item) in
              //선택한 Item을 TextField에 넣어준다.
            self!.mainView.categoryListButton.setTitle(item, for: .normal)
            self!.categoryItem = item
          }
        
        basicPriceDropDwon.dismissMode = .automatic
        basicPriceDropDwon.dataSource = basicPriceDefault
        basicPriceDropDwon.anchorView = mainView.basicPriceDropView
        basicPriceDropDwon.bottomOffset =  CGPoint(x: 0, y: mainView.basicPriceDropView.bounds.height)
        basicPriceDropDwon.selectionAction = { [weak self] (index, item) in

            self!.mainView.selectSettingButton.setTitle(item, for: .normal)
            self!.selectedBasicPrice = item
            self!.basicPriceViewModel.input.priceType.accept(BasicPriceType.getPriceData(selectPrice: item))
            self!.mainView.basicPriceTableView.isHidden = false
          
          }
    }
    
    @objc func addRealm(){
        let object = MenuData()
        object.menuName = mainView.nameTextField.text!
        object.price = mainView.priceTextField.text!
        object.category = self.categoryItem
        saveImageToDocumentDirectory(imageName: "\(object._id).png", image: mainView.selectImageButton.imageView!.image!)
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


extension AddMenuVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL {
            let imagePath = imageURL.absoluteString
            self.imagePath = imagePath
            let data = try? Data(contentsOf: imageURL)
            if let imageData = data {
                mainView.selectImageButton.setImage(UIImage(data: imageData), for: .normal)
            }
        }
        
        dismiss(animated: true)
    }
    
    
}

extension AddMenuVC:UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == mainView.userInputPriceTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInputOptionCell.identifier, for: indexPath) as? UserInputOptionCell else  { return }
         
            cell.disposeBag = disposeBag
        }
       
    }
}

extension AddMenuVC: KeyBoardShowHideDelegate {
    func keyboardShowUpdateView() {
        self.mainView.addButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-500)
        }
    }
    
    func keyboardHideUpdateView() {
        self.mainView.addButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-52)
        }
    }
    
}
