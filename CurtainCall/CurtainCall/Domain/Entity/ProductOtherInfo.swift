//
//  ProductOtherInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit

struct ProductOtherInfo: Hashable {
    // TODO: URL로 변경 예정
    let profileImage: UIImage?
    let nickname: String
    let writeDate: Date
    let maxCount: Int
    let minCount: Int
    let content: String
    let meetingDate: Date?
    
    // MARK: 더미데이터
    
    static let list: [ProductOtherInfo] = [
        ProductOtherInfo(
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "고라파덕",
            writeDate: Date(),
            maxCount: 5,
            minCount: 1,
            content: "데스노트 굿즈 같이 만들 사람?",
            meetingDate: nil
        ),
        ProductOtherInfo(
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "gorapaduck",
            writeDate: Date(),
            maxCount: 3,
            minCount: 5,
            content: "김준수 포토카드 같이 만들어요~김준수 포토카드 같이 만들어요~김준수 포토카드 같이 만들어요~",
            meetingDate: Date()
        ),
        ProductOtherInfo(
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "gorapaduck",
            writeDate: Date(),
            maxCount: 3,
            minCount: 5,
            content: "400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자",
            meetingDate: Date()
        )
    ]
}
