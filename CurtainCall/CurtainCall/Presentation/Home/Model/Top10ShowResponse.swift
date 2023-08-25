//
//  Top10ShowResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/26.
//

import Foundation

struct Top10ShowResponse: Decodable {
    let content: [Top10ShowContent]
}

struct Top10ShowContent: Hashable, Decodable {
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let poster: String
    let genre: String
    let reviewGradeSum: Double
    let reviewCount: Double
    let rank: Int
}
