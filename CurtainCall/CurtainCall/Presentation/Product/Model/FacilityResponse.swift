//
//  FacilityResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

struct FacilityResponse: Decodable {
    let id: String
    let name: String
    let hallNum: Int
    let characteristic: String
    let openingYear: Int?
    let seatNum: Int?
    let phone: String
    let homepage: String
    let address: String
    let latitude: Double
    let longitude: Double
}
