//
//  FavoriteService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

final class FavoriteService {
    static let shared = FavoriteService()
    private init() { }
    
    var isFavoriteIds: Set<String> = []
}
