//
//  UserInputPriceViewModel.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/11.
//

import Foundation
import RxSwift
import RxCocoa

class UserInputPriceViewModel:BaseViewModel,ViewModelType {
    
    var input: Input = Input()
    var output: Output = Output()
 
    struct Input {
        let userInputList = PublishRelay<[PriceListType]>()
    }
    
    struct Output{
        let priceList = BehaviorRelay<[PriceListType]>(value: [])
    }
    let cellTextValues: [Observable<String>] = []
    
    override init() {
        super.init()
  
    }
    
    override func bindRx() {
        input.userInputList
            .subscribe(with: self,onNext: {owner, input in
                owner.output.priceList.accept(input)
            })
            .disposed(by: disposeBag)
    }
}
