//
//  NoticeDetailResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation

struct NoticeDetailResponse: Decodable {
    let id: Int
    let title: String
    let content: String
    let createdAt: String
}
