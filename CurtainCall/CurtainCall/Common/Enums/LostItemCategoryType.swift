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
}
