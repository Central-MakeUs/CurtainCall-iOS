//
//  ShowReviewReponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/21.
//

import Foundation

struct ShowReviewResponse: Decodable {
    let content: [ShowReviewContent]
}

struct ShowReviewContent: Decodable {
    let id: Int
    let showId: String
    let grade: Double
    let content: String
    let creatorId: Int
    let creatorNickname: String
    let creatorImageUrl: String?
    let createdAt: String
    let likeCount: Int?
}
