//
//  LikeReviewService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/28.
//

import Foundation

final class LikeReviewService {
    static let shared = LikeReviewService()
    private init() { }
    
    var isLikeReview = Set<Int>()
}
