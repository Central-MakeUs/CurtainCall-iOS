//
//  LostItemDetailResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

struct LostItemDetailResponse: Decodable {
    let id: Int
    let facilityId: String
    let facilityName: String
    let facilityPhone: String
    let title: String
    let type: String
    let foundPlaceDetail: String
    let foundDate: String
    let foundTime: String
    let particulars: String
    let imageId: Int
    let imageUrl: String
}
