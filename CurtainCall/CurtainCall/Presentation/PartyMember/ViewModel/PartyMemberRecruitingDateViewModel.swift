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
    
    @Published var countValue: Int = 1
    
    // MARK: - Lifecycles
    
    // MARK: - Helpers
    
    func countValueChanged(_ value: Int) {
        countValue = max(countValue + value, 1)
    }
}
