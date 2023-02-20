//
//  BasicPriceManager.swift
//  AAMenu
//
//  Created by 권오현 on 2023/02/04.
//

import Foundation

struct BasicPrice {
    var basicTypeName: String
    var basicList: [PriceListType]
  
}

struct PriceListType {
    var name: String
    var price: String
}



enum BasicPriceType:CaseIterable {
    case SizeUp
    case HotIce
    case Size
    
//MARK: Default = ["Size-Up","Hot/Ice","SIZE"]
    
    func getTypeName() ->String {
        switch self {
        case .SizeUp:
            return "Size-Up"
        case .HotIce:
            return "Hot/Ice"
        case .Size:
            return "Size"
        }
    }
    
    func setPriceType()->BasicPrice{
        
        switch self {
        case .SizeUp:
            return BasicPrice(basicTypeName: "Size-Up",
                              basicList: [PriceListType(name: "SizeUp", price: "")])
        case .HotIce:
            return BasicPrice(basicTypeName: "Hot/Ice",
                              basicList: [PriceListType(name: "HOT", price: ""),
                                         PriceListType(name: "ICE", price: "")])
        case .Size:
            return BasicPrice(basicTypeName: "Size",
                              basicList: [PriceListType(name: "S", price: ""),
                                         PriceListType(name: "M", price: ""),
                                         PriceListType(name: "L", price: "")])
        }
    }
    
    static func getPriceData(selectPrice:String)-> BasicPrice {
        var result : BasicPrice?
        BasicPriceType.allCases.forEach { type in
            if selectPrice == type.getTypeName() {
                return result = type.setPriceType()
            }
        }
        return result!
    }
    
    static func allCasesTypeName()->[String] {
        var result = [String]()
        BasicPriceType.allCases.forEach { type in
            result.append(type.getTypeName())
        }
        return result
    }
}


