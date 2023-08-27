//
//  PartyListResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/23.
//

import Foundation

struct PartyListResponse: Decodable {
    let content: [PartyListContent]
}

struct PartyListContent: Decodable, Hashable {
    let id: Int
    let title: String
    let curMemberNum: Int
    let maxMemberNum: Int
    let showAt: String?
    let createdAt: String
    let category: String
    let creatorId: Int
    let creatorNickname: String
    let creatorImageUrl: String?
    let showId: String?
    let showName: String?
    let showPoster: String?
    let facilityId: String?
    let facilityName: String?
}
