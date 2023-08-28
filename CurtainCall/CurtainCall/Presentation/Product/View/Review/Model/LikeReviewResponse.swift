//
//  LikeReviewResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/28.
//

import Foundation

struct LikeReviewResponse: Decodable {
    let content: [LikeReviewContent]
}

struct LikeReviewContent: Decodable {
    let showReviewId: Int
    let liked: Bool
}
