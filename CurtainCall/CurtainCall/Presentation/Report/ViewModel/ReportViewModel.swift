//
//  ReportViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import Foundation
import Combine

final class ReportViewModel {
    
    @Published var isChecked: Bool = false
    
    
    func isCheckReport(tag: [Int]) {
        isChecked = !tag.isEmpty
    }
}
