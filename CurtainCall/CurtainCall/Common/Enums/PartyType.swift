//
//  PartyType.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/10.
//

enum PartyType {
    case product
    case food
    case other
    
    init?(tag: Int) {
        switch tag {
        case 0: self = .product
        case 1: self = .food
        case 2: self = .other
        default: return nil
        }
    }
    
    var title: String {
        switch self {
        case .product:
            return "공연 관람"
        case .food:
            return "식사/카페"
        case .other:
            return "기타"
        }
    }
}
