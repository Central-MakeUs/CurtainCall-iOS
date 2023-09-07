//
//  TalkMessageData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import Foundation

enum ChatType {
    case receive
    case send
}

struct TalkMessageData {
    let chatType: ChatType
    let nickname: String
    let message: String
    let createAt: Date
    let imageURL: URL?
}
