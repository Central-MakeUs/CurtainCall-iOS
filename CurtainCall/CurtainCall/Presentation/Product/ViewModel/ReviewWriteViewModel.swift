//
//  ReviewWriteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/31.
//

import Foundation
import Combine

final class ReviewWriteViewModel {
    
    // MARK: - Properties
    
    @Published var isValidReview: Bool = false
    
    // MARK: - Helpers
    
    func reviewTextViewChanged(text: String?) {
        guard let text, !text.isEmpty, text != Constants.REVIEW_WRITE_TEXTVIEW_PLACEHOLDER else {
            isValidReview = false
            return
        }
        isValidReview = true
    }
}
