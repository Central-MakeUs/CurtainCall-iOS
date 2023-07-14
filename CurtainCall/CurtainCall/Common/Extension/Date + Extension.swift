//
//  Date + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation

extension Date {
    func convertToYearMonthDayHourMinString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.M.dd HH:mm"
        return formatter.string(from: self)
    }
    
    func convertToYearMonthDayWeekString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.M.dd (E)"
        return formatter.string(from: self)
    }
    
    func convertToHourMinString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func convertToDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    func convertToYearMonthKoreanString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: self)
    }
}
