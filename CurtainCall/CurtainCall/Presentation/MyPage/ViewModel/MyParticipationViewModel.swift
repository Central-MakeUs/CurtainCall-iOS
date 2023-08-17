//
//  MyParticipationViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import Foundation
import Combine

final class MyParticipationViewModel {
    
    var myParticipationSubject = PassthroughSubject<[ProductPartyInfo], Error>()
    
    init() {
        requestMyRecruitment()
    }
    
    func requestMyRecruitment() {
        myParticipationSubject.send(ProductPartyInfo.list)
    }
}

