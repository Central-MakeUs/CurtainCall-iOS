//
//  LostItemResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

struct LostItemResponse: Decodable {
    let content: [LostItemContent]
}

struct LostItemContent: Hashable, Decodable {
    let id: Int
    let facilityId: String
    let facilityName: String
    let title: String
    let foundDate: String
    let foundTime: String?
    let imageUrl: String?
}
