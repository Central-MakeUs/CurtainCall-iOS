//
//  CreateLostItemBody.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

struct CreateLostItemBody: Encodable {
    let title: String
    let type: String
    let facilityId: String
    let foundPlaceDetail: String
    let foundDate: String
    let foundTime: String?
    let particulars: String
    let imageId: Int
}
