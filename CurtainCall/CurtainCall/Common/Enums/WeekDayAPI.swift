//
//  WeekDayAPI.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

enum WeekDayAPI: String {
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRYDAY
    case SATURDAY
    case SUNDAY
    
    var KRname: (String, Int) {
        switch self {
        case .MONDAY: return ("월", 0)
        case .TUESDAY: return ("화", 1)
        case .WEDNESDAY: return ("수", 2)
        case .THURSDAY: return ("목", 3)
        case .FRYDAY: return ("금", 4)
        case .SATURDAY: return ("토", 5)
        case .SUNDAY: return ("일", 6)
        }
    }
}
