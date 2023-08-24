//
//  MyRecruimentResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation

struct MyRecruitmentResponse: Decodable {
    let content: [MyRecruitmentContent]
}

struct MyRecruitmentContent: Hashable, Decodable {
    let id: Int
    let title: String
    let curMemberNum: Int
    let maxMemberNum: Int
    let showAt: String
    let createdAt: String
    let category: String
    let creatorId: Int
    let creatorNickname: String
    let creatorImageUrl: String?
    let showId: String
    let showName: String
    let showPoster: String
    let facilityId: String
    let facilityName: String
}
