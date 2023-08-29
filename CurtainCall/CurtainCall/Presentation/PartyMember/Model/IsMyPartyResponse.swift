//
//  IsMyPartyResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/29.
//

import Foundation

struct IsMyPartyResponse: Decodable {
    let content: [IsMyPartyContent]
}

struct IsMyPartyContent: Decodable {
    let partyId: Int
    let participated: Bool
}

