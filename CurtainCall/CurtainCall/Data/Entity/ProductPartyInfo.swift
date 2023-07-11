//
//  ProductPartyInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/11.
//

import UIKit

struct ProductPartyInfo: Hashable {
    let productName: String
    // TODO: URL로 변경 예정
    let profileImage: UIImage
    let nickname: String
    let writeDate: Date
    let productDate: Date
    let maxCount: Int
    let minCount: Int
    let content: String
    let posterImage: UIImage
    let location: String
    let partyMemberImages: [UIImage]
}
