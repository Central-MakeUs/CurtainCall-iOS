//
//  OpenShowResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/26.
//

import Foundation

struct OpenShowResponse: Decodable {
    let content: [OpenShowContent]
}

struct OpenShowContent: Hashable, Decodable {
    let id: String
    let name: String
    let startDate: String
    let poster: String
    let reviewCount: Double
    let reviewGradeSum: Double
}
