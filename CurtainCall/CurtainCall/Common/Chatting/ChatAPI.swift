//
//  ChatAPI.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import Foundation

import Moya
import CombineMoya
import SwiftKeychainWrapper

enum ChatAPI {
    case requestToken
}

extension ChatAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .requestToken:
            return "/chat-token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestToken:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .requestToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
}
