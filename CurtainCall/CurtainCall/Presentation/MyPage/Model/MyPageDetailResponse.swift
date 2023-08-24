//
//  MyPageDetailResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation

struct MyPageDetailResponse: Decodable {
    let id: Int
    let nickname: String
    let imageId: String?
    let imageUrl: String?
    let recruitingNum: Int
    let participationNum: Int
}
