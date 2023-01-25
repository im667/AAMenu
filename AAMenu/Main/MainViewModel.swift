//
//  MainViewModel.swift
//  AAMenu
//
//  Created by 권오현 on 2022/12/17.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input : Input { get }
    var output : Output { get }
}


class BaseViewModel : NSObject {

    var disposeBag = DisposeBag()

    override init() {
        super.init()
        rxBind()
    }

    deinit {
        print("> deinit VM - \(type(of: self))")
    }

    func rxBind() {
    }
}


class MainViewModel:BaseViewModel,ViewModelType {
    
    var input: Input = Input()
    var output: Output = Output()
 
    struct Input {
        let filterType = PublishRelay<[String]>()
    }
    
    struct Output{
        let menuList = BehaviorRelay<[MenuData]>(value: [])
    }
    
    override init() {
        super.init()
  
    }

    
    override func rxBind(){
        input.filterType
            .subscribe(with:self,onNext: { owner, filter in
                let menuList = RealmManager.shared.getFilterMenu(category: filter).toArray()
                
                owner.output.menuList.accept(menuList)
            })
            .disposed(by: disposeBag)
    }
    
}
