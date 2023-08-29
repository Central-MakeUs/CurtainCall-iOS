//
//  String + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import Foundation

extension String {
    func isValidRegex(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func convertYearMonthDayHourMinStringToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 dd일 HH:mm"
        return formatter.date(from: self)
    }
    
    func convertYearMonthDayDashStringToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
    
    func convertAPIDateToDate() -> Date? {
        let d = self.components(separatedBy: ["T","."]).joined(separator: " ").split(separator: " ").map { String($0) }
        let times = d[1].split(separator: ":").map { String($0) }
        let time = times[0] + ":" + times[1]
        let date = d[0] + time
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddHH:mm"
        return formatter.date(from: date)
    }
    
    func convertAPIDateToDateString() -> String {
        var d = self.components(separatedBy: ["T","."]).joined(separator: " ").split(separator: " ").map { String($0) }.first ?? ""
        d = d.replacingOccurrences(of: ":", with: "-")
        return d
    }
    
    func convertAPIDateToDateWeekString() -> String {
        var d = self.components(separatedBy: ["T","."]).joined(separator: " ").split(separator: " ").map { String($0) }.first ?? ""
        d = d.replacingOccurrences(of: ":", with: "-")
        guard let date = d.convertYearMonthDayDashStringToDate() else { return "" }
        return date.convertToYearMonthDayWeekString()
    }
    
    func convertAPIDateToDateTime() -> String {
        let d = self.components(separatedBy: ["T","."]).joined(separator: " ").split(separator: " ").map { String($0) }[1]
        let times = d.split(separator: ":").map { String($0) }
        return times[0] + ":" + times[1]
    }
}
