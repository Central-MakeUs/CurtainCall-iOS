//
//  MyRecruitmentViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import Foundation
import Combine

final class MyRecruitmentViewModel {
    
    var myRecruitmentSubject = PassthroughSubject<[ProductPartyInfo], Error>()
    
    init() {
        requestMyRecruitment()
    }
    
    func requestMyRecruitment() {
        myRecruitmentSubject.send(ProductPartyInfo.list)
    }
}
