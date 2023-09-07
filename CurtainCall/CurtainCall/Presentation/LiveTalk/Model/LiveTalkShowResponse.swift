//
//  LiveTalkShowResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/07.
//

import Foundation

struct LiveTalkShowResponse: Hashable, Decodable {
    let content: [LiveTalkShowContent]
}

struct LiveTalkShowContent: Hashable, Decodable {
    let id: String
    let name: String
    let facilityId: String
    let facilityName: String
    let poster: String
    let genre: String
    let showAt: String
    let showEndAt: String
}
