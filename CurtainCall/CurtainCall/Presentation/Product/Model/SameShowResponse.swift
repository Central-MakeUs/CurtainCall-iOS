//
//  SameShowResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/08.
//

import Foundation

struct SameShowResponse: Decodable {
    let content: [SameShowContent]
}

struct SameShowContent: Hashable, Decodable {
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let facilityName: String
    let poster: String
    let genre: String
    let reviewCount: Double
    let reviewGradeSum: Double
    let runtime: String
}
