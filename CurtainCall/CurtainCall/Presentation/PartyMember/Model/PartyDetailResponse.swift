//
//  PartyDetailResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

struct PartyDetailResponse: Decodable {
    let id: Int
    let title: String
    let content: String
    let category: String?
    let curMemberNum: Int
    let maxMemberNum: Int
    let showAt: String?
    let creatorId: Int
    let createdAt: String
    let creatorNickname: String
    let creatorImageUrl: String?
    let showId: String?
    let showName: String?
    let facilityId: String?
    let facilityName: String?
}
