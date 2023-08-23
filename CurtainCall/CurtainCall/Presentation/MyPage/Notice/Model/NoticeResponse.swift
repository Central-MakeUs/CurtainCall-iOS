//
//  NoticeResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation

struct NoticeResponse: Decodable {
    let content: [NoticeContent]
}

struct NoticeContent: Decodable {
    let id: Int
    let title: String
    let createdAt: String
}
