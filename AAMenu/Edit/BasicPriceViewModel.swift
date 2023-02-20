//
//  EditMenuViewModel.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/04.
//

import Foundation
import RxCocoa
import RxSwift

class BasicPriceViewModel :BaseViewModel,ViewModelType {
    
    var input: Input = Input()
    var output: Output = Output()
 
    struct Input {
        let priceType = PublishRelay<BasicPrice>()
    }
    
    struct Output{
        let priceList = BehaviorRelay<[PriceListType]>(value: [PriceListType(name: "", price: "")])
    }
    
    override init() {
        super.init()
  
    }

    override func bindRx(){
        input.priceType
            .subscribe(with: self,onNext: {owner, priceType in
                let price = priceType.basicList
                owner.output.priceList.accept(price)
            })
            .disposed(by: disposeBag)
    }
    
}

