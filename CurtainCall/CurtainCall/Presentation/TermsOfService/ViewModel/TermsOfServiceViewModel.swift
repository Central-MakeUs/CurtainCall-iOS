//
//  TermsOfServiceViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import Foundation
import Combine

protocol TermsOfServiceViewModelInput {
    func checkButtonTouchUpInside(tag: Int)
}

protocol TermsOfServiceViewModelOutput {
    var isAllCheck: CurrentValueSubject<Bool, Never> { get set }
    var isServiceCheck: CurrentValueSubject<Bool, Never> { get set }
    var isLocationCheck: CurrentValueSubject<Bool, Never> { get set }
    var isAlarmCheck: CurrentValueSubject<Bool, Never> { get set }
    var isMarketingCheck: CurrentValueSubject<Bool, Never> { get set }
    var isCheckedRequire: CurrentValueSubject<Bool, Never> { get set }
}

final class TermsOfServiceViewModel: TermsOfServiceViewModelInput, TermsOfServiceViewModelOutput {
    var isAllCheck = CurrentValueSubject<Bool, Never>(false)
    var isServiceCheck = CurrentValueSubject<Bool, Never>(false)
    var isLocationCheck = CurrentValueSubject<Bool, Never>(false)
    var isAlarmCheck = CurrentValueSubject<Bool, Never>(false)
    var isMarketingCheck = CurrentValueSubject<Bool, Never>(false)
    var isCheckedRequire = CurrentValueSubject<Bool, Never>(false)
    
    func checkButtonTouchUpInside(tag: Int) {
        switch tag {
        case 0:
            isAllCheck.value.toggle()
            isServiceCheck.value = isAllCheck.value
            isLocationCheck.value = isAllCheck.value
            isAlarmCheck.value = isAllCheck.value
            isMarketingCheck.value = isAllCheck.value
        case 1: isServiceCheck.value.toggle()
        case 2: isLocationCheck.value.toggle()
        case 3: isAlarmCheck.value.toggle()
        case 4: isMarketingCheck.value.toggle()
        default: fatalError()
        }
        allCheckButtonStateManage()
        isCheckedRequire.value = isAllCheck.value
    }
    
    func allCheckButtonStateManage() {
        isAllCheck.value = isServiceCheck.value && isLocationCheck.value &&
        isAlarmCheck.value
    }
}
