//
//  RemoveAccountBody.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation

struct RemoveAccountBody: Encodable {
    let reason: String
    let content: String
}
