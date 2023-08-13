//
//  AuthenticationResponse.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/13.
//

import Foundation

struct AuthenticationResponse: Decodable {
    let memberId: Int
    let accessToken: String
    let accessTokenExpiresAt: String?
    let refreshToken: String
    let refreshTokenExpiresAt: String?
}
