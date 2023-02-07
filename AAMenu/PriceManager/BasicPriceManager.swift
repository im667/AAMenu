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
    var priceType:String
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
            return "SIZE"
        }
    }
    
    func setPriceType()->BasicPrice{
        
        switch self {
        case .SizeUp:
            return BasicPrice(basicTypeName: "SizeUp",
                              basicList: [PriceListType(priceType: "SizeUp")])
        case .HotIce:
            return BasicPrice(basicTypeName: "Hot/Ice",
                              basicList: [PriceListType( priceType: "Hot"),
                                         PriceListType(priceType: "Ice")])
        case .Size:
            return BasicPrice(basicTypeName: "Size",
                              basicList: [PriceListType(priceType: "Small"),
                                         PriceListType(priceType: "Medium"),
                                         PriceListType(priceType: "Large")])
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


