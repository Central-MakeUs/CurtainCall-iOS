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
    
//    static let list: [TalkMessageData] = [
//        TalkMessageData(chatType: .receive, nickname: "만도스", message: "와와와우우우 채팅UI 테스트"),
//        TalkMessageData(chatType: .receive, nickname: "니카", message: "와와와우우우 채팅UI 테스트와와와우우우 채팅UI 테스트와와와우우우 채팅UI 테스트와와와우우우 채팅UI 테스트와와와우우우 채팅UI 테스트"),
//        TalkMessageData(chatType: .send, nickname: "나", message: "하이요하이요하이요하이요하이요하이요하이요하이요하이요"),
//        TalkMessageData(chatType: .receive, nickname: "저스틴", message: "하이"),
//        TalkMessageData(chatType: .send, nickname: "나", message: "하이"),
//        TalkMessageData(chatType: .receive, nickname: "재야", message: "만나서 반가워요."),
//        TalkMessageData(chatType: .send, nickname: "나", message: "하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요하이요"),
//        TalkMessageData(chatType: .receive, nickname: "준", message: "만나서 반갑습니다~"),
//        TalkMessageData(chatType: .receive, nickname: "준", message: "만나서 반갑습니다~!!!! 허ㅗ호"),
//    ]
}
