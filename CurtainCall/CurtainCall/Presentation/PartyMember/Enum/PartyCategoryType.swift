//
//  PartyCategoryType.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/23.
//

import Foundation

enum PartyCategoryType: String {
    case watching = "WATCHING"
    case food = "FOOD_CAFE"
    case etc = "ETC"
    
    init?(tag: Int) {
        switch tag {
        case 0: self = .watching
        case 1: self = .food
        case 2: self = .etc
        default: return nil
        }
    }
    
    var title: String {
        switch self {
        case .watching:
            return "공연 관람"
        case .food:
            return "식사/카페"
        case .etc:
            return "기타"
        }
    }
}
