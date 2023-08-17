//
//  MyRecruitmentEditViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import Foundation
import Combine

final class MyRecruitmentEditViewModel {
    
    // MARK: - Properties
    
    @Published var isValidTitle: Bool = true
    @Published var isValidContent: Bool = true
    
    var isValid: AnyPublisher<Bool, Never> {
        return $isValidTitle.combineLatest($isValidContent) {
            return $0 && $1
        }.eraseToAnyPublisher()
    }
    
    // MARK: - Helpers
    
    func titleTextFieldChanged(text: String?) {
        guard let text, !text.isEmpty else {
            isValidTitle = false
            return
        }
        isValidTitle = true
    }
    
    func contentTextViewChanged(text: String?) {
        guard let text, !text.isEmpty else {
            isValidContent = false
            return
        }
        isValidContent = true
    }
    
    
}
