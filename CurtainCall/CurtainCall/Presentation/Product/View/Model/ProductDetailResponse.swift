//
//  ProductDetailResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/21.
//

import Foundation

struct ProductDetailResponse: Decodable {
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let facilityId: String
    let facilityName: String
    let crew: String
    let cast: String
    let runtime: String
    let age: String
    let enterprise: String
    let ticketPrice: String
    let poster: String
    let story: String
    let genre: String
    let introductionImages: [String]
    let showTimes: [ProductDetailShowTime]
    let reviewCount: Double
    let reviewGradeSum: Double
}

struct ProductDetailShowTime: Decodable {
    let dayOfWeek: String
    let time: String
}
