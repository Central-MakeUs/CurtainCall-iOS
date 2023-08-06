//
//  LostItemWriteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/06.
//

import Foundation
import Combine

final class LostItemWriteViewModel {
    @Published var isTitleWrite = false
    @Published var isCategoryWrite = false
    @Published var isKeepDateWrite = false
    @Published var isAddFile = false
    
     
    
    func titleTextFieldChanged(text: String?) {
        guard let text, !text.isEmpty else {
            isTitleWrite = false
            return
        }
        isTitleWrite = true
        
        var isValid = $isTitleWrite.combineLatest($isCategoryWrite, $isKeepDateWrite, $isAddFile)
            .eraseToAnyPublisher()
    }
    
    func selectDate(date: Date) {
        isKeepDateWrite = true
    }
    
    func selectTime(date: Date) {
        
    }
    
    func addFile() {
        isAddFile = true
    }
}
