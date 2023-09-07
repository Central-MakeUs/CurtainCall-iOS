//
//  Date + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import Foundation

extension Date {
    func convertToYearMonthDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.M.dd"
        return formatter.string(from: self)
    }
    func convertToAPIDateYearMonthDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    func convertToYearMonthDayHourMinString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.M.dd HH:mm"
        return formatter.string(from: self)
    }
    
    func convertToYearMonthDayWeekString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd(E)"
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
    
    func convertToYearMonthDayKoreanString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 dd일"
        return formatter.string(from: self)
    }
    
    func convertToChatDateToKorean() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd (E) a h시 m분"
        return formatter.string(from: self)
    }
    
    func convertToWeekend() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self).uppercased()
    }
    
    static func getDuringDate(start: String, end: String) -> [Date] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard var startDate = formatter.date(from: start),
              let endData = formatter.date(from: end) else {
            return []
        }
        let calendar = Calendar.current
        var result: [Date] = [startDate]
        
        while startDate < endData {
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: startDate) else {
                break
            }
            result.append(nextDay)
            startDate = nextDay
        }
        return result
        
    }
    
    static func currentTo90Days() -> [Date] {
        let calendar = Calendar.current
        var startDate = Date()
        var result: [Date] = [startDate]
        for _ in 0..<90 {
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: startDate) else {
                break
            }
            result.append(nextDay)
            startDate = nextDay
        }
        return result
    }
}

extension [Date] {
    func convertToYearMonthDayKeyHourValue() -> [String: [String]] {
        var dateDict: [String: [String]] = [:]
        for date in self.map({ $0.convertToYearMonthDayHourMinString().split(separator: " ").map { String($0) } }) {
            dateDict[date[0], default: []].append(date[1])
        }
        return dateDict
    }
}
