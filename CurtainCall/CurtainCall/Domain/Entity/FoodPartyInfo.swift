//
//  FoodPartyInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit

struct FoodPartyInfo: Hashable {
    let productName: String
    // TODO: URL로 변경 예정
    let profileImage: UIImage?
    let nickname: String
    let writeDate: Date
    let productDate: Date
    let maxCount: Int
    let minCount: Int
    let content: String
    let posterImage: UIImage?
    let location: String
    let partyMemberImages: [UIImage?]
    
    // MARK: 더미데이터
    
    static let list: [FoodPartyInfo] = [
        FoodPartyInfo(
            productName: "비스티",
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "고라파덕",
            writeDate: Date(),
            productDate: Date(),
            maxCount: 5,
            minCount: 2,
            content: "비스티 이번주 토욜 저녁 공연보고 음식 먹을군 괌~",
            posterImage: UIImage(named: "dummy_poster"),
            location: "링크아트센터",
            partyMemberImages: [
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member")
            ]
        ),
        FoodPartyInfo(
            productName: "데스노트",
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "himusical",
            writeDate: Date(),
            productDate: Date(),
            maxCount: 5,
            minCount: 5,
            content: "6/11 일요일 19:30 같이 음식 드실 분 계십니까",
            posterImage: UIImage(named: "dummy_poster"),
            location: "블루스퀘어",
            partyMemberImages: [
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member")
            ]
        ),
        FoodPartyInfo(
            productName: "데스노트",
            profileImage: UIImage(named: "dummy_profile"),
            nickname: "himusical",
            writeDate: Date(),
            productDate: Date(),
            maxCount: 5,
            minCount: 3,
            content: "400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자400자",
            posterImage: UIImage(named: "dummy_poster"),
            location: "블루스퀘어",
            partyMemberImages: [
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member"),
                UIImage(named: "dummy_party_member")
            ]
        )
        
    ]
}
