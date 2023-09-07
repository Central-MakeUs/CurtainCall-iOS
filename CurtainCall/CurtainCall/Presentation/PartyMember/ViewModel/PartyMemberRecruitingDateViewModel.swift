//
//  PartyMemberRecruitingDateViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/16.
//

import Foundation
import Combine

final class PartyMemberRecruitingDateViewModel {
    
    // MARK: - Properties
    
    @Published var countValue: Int = 2
    var selectedDate = CurrentValueSubject<Date?, Never>(nil)
    
    // MARK: - Lifecycles
    
    // MARK: - Helpers
    
    func countValueChanged(_ value: Int) {
        if !(2...10 ~= (countValue + value)) {
            return
        }
        countValue = countValue + value
    }
    
    func isValidDate(date: String?, time: String?) {
        guard let dateString = date,
              let time,
              let date = "\(dateString) \(time)".convertYearMonthDayHourMinStringToDate()
        else {
            selectedDate.send(nil)
            return
        }
        selectedDate.send(date)
    }
}
