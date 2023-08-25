//
//  LostItemCategoryType.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/01.
//

import Foundation

enum LostItemCategoryType: Int {
    case bag = 1
    case wallet
    case cash
    case card
    case jewel
    case phone
    case book
    case clothes
    case other
    
    var name: String {
        switch self {
        case .bag: return "가방"
        case .wallet: return "지갑"
        case .cash: return "현금"
        case .card: return "카드"
        case .jewel: return "귀금속"
        case .phone: return "전자기기"
        case .book: return "도서"
        case .clothes: return "의류"
        case .other: return "기타"
        }
    }
    
    var apiName: String {
        switch self {
        case .bag: return "BAG"
        case .wallet:
            return "WALLET"
        case .cash:
            return "CASH"
        case .card:
            return "CARD"
        case .jewel:
            return "JEWELRY"
        case .phone:
            return "ELECTRONIC_EQUIPMENT"
        case .book:
            return "BOOK"
        case .clothes:
            return "CLOTHING"
        case .other:
            return "ETC"
        }
    }
    
    init(apiName: String) {
        switch apiName {
        case "BAG": self = .bag
        case "WALLET": self = .wallet
        case "CASH": self = .cash
        case "CARD": self = .card
        case "JEWELRY": self = .jewel
        case "ELECTRONIC_EQUIPMENT": self = .phone
        case "BOOK": self = .book
        case "CLOTHING": self = .clothes
        case "ETC": self = .other
        default: self = .other
        }
    }
}
