//
//  PartyMemberOtherRecruitingDateViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/22.
//

import Foundation
import Combine

final class PartyMemberOtherRecruitingDateViewModel {
    // MARK: - Properties
    
    @Published var countValue: Int = 2
    var selectedDate = PassthroughSubject<Date?, Never>()
    
    // MARK: - Lifecycles
    
    // MARK: - Helpers
    
    func countValueChanged(_ value: Int) {
        if !(2...100 ~= (countValue + value)) {
            return
        }
        countValue = countValue + value
    }
    
    func isValidDate(date: String?) {
        guard let dateString = date,
              let date = dateString.convertYearMonthDayHourMinStringToDate()
        else {
            selectedDate.send(nil)
            return
        }
        selectedDate.send(date)
    }
}
