//
//  FavoriteProductListResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation

struct FavoriteProductListResponse: Decodable {
    let content: [FavoriteProductListContent]
}

struct FavoriteProductListContent: Decodable {
    let showId: String
    let favorite: Bool
}
