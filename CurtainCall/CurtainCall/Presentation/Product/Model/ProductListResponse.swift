//
//  ProductListResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/17.
//

import Foundation

struct ProductListResponse: Decodable, Hashable {
    let content: [ProductListContent]
}

struct ProductListContent: Decodable, Hashable {
    let id: String
    let name: String
    let startDate: String // "2023-04-28",
    let endDate: String // "2023-05-12",
    let facilityName: String // "예술나눔 터",
    let poster: String // "http://www.kopis.or.kr/upload/pfmPoster/PF_PF220846_230704_164730.jpg",
    let genre : String
    let showTimes: [ProductListShowTime]
    let runtime: String
    let reviewCount: Double
    let reviewGradeSum: Double
}

struct ProductListContentHaveSelected: Hashable {
    let id: String
    let name: String
    let startDate: String // "2023-04-28",
    let endDate: String // "2023-05-12",
    let facilityName: String // "예술나눔 터",
    let poster: String // "http://www.kopis.or.kr/upload/pfmPoster/PF_PF220846_230704_164730.jpg",
    let genre : String
    let showTimes: [ProductListShowTime]
    let runtime: String
    let reviewCount: Double
    let reviewGradeSum: Double
    var isSelected: Bool = false
}

struct ProductListShowTime: Decodable, Hashable {
    let dayOfWeek: String // "THURSDAY",
    let time: String // "13:30:00"
}
