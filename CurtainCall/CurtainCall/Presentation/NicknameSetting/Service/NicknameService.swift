//
//  nicknameService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/16.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum NicknameAPI {
    case duplicate(String)
}

extension NicknameAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String { "/members/duplicate/nickname" }
    
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .duplicate(let nickname):
            param.updateValue(nickname, forKey: "nickname")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
}
