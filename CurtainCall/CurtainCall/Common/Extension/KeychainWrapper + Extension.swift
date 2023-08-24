//
//  KeychainWrapper + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/16.
//

import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    static let accessToken: KeychainWrapper.Key = "accessToken"
    static let userID: KeychainWrapper.Key = "userID"
    static let refreshToken: KeychainWrapper.Key = "refreshToken"
}
