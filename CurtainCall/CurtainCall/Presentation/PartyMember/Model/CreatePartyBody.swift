//
//  CreatePartyBody.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/23.
//

import Foundation

struct CreatePartyBody: Encodable {
    let showId: String?
    let showAt: String?
    let title: String
    let content: String
    let maxMemberNum: Int
    let category: String
}
