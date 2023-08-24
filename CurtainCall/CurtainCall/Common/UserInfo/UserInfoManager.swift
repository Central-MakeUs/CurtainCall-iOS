//
//  UserInfoManager.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation

final class UserInfoManager {
    static let shared = UserInfoManager()
    
    private init() { }
    
    var userInfo: MyPageDetailResponse?
    
}
