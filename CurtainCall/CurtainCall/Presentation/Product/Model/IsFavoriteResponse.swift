//
//  IsFavoriteResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

struct IsFavoriteResponse: Decodable {
    let content: [IsFavoriteContent]
}

struct IsFavoriteContent: Decodable {
    let showId: String
    let favorite: Bool
}
