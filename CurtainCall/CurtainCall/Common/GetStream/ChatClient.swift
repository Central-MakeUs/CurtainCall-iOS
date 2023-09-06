//
//  ChatClient.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import Foundation

import StreamChat

extension ChatClient {
    static let shared = ChatClient(config: ChatClientConfig(apiKey: .init(Secret.CHAT_CLIENT_APPKEY)))
//    func connectUser(userId: String, name: String) {
//        let userInfo = UserInfo(id: userId, name: name)
//        ChatClient.shared.connectUser(userInfo: userInfo, token: .development(userId: <#T##UserId#>))
//    }
    func connectSuperUser() {
        ChatClient.shared.connectUser(
            userInfo: .init(id: "super-user"),
            token: .development(userId: "super-user")
        )
    }
//    func createChannel(id: String) {
//        let channelId = ChannelId(type: .messaging, id: id)
//        ChatClient.shared.chan
//    }
    
    
}

struct ChannelManager {
    static let superChannelId = ChannelId(type: .messaging, id: "super-channel-mandos")
}
