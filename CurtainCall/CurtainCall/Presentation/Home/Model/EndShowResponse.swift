//
//  EndShowReponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/28.
//

import Foundation

struct EndShowResponse: Decodable {
    let content: [EndShowContent]
}

struct EndShowContent: Hashable, Decodable {
    let id: String
    let name: String
    let endDate: String
    let poster: String
    let reviewCount: Double
    let reviewGradeSum: Double
}
