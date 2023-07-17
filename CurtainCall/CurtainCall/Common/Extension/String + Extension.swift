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
}
