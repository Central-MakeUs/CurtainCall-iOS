//
//  OtherPartyInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit

struct OtherPartyInfo: Hashable {
    // TODO: URL로 변경 예정
    let profileImage: UIImage?
    let nickname: String
    let writeDate: Date
    let maxCount: Int
    let minCount: Int
    let title: String
    let content: String
    let meetingDate: Date?
    let partyMemberImages: [UIImage?]
    
    // MARK: 더미데이터
    
    static let list: [OtherPartyInfo] = [
        OtherPartyInfo(
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "고라파덕",
            writeDate: Date(),
            maxCount: 5,
            minCount: 1,
            title: "데스노트 굿즈 같이 만들 사람?",
            content: "만들사람 구해요",
            meetingDate: nil,
            partyMemberImages: [UIImage(named: "dummy_party_member")]
        ),
        OtherPartyInfo(
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "gorapaduck",
            writeDate: Date(),
            maxCount: 5,
            minCount: 3,
            title: "김준수 포토카드 같이 만들어요!김준수 포토카드 같이 만들어요~",
            content: "만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발만들자제발",
            meetingDate: Date(),
            partyMemberImages: [
                UIImage(named: "dummy_party_member"), UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member")
            ]
        ),
        OtherPartyInfo(
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "gorapaduck",
            writeDate: Date(),
            maxCount: 5,
            minCount: 3,
            title: "긴글입니닥!",
            content: "400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자",
            meetingDate: Date(),
            partyMemberImages: [
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member")
            ]
        )
    ]
}
