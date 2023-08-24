//
//  RemoveAccountService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum RemoveAccountAPI {
    case removeAccount(body: RemoveAccountBody)
}

extension RemoveAccountAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        return "/member"
    }
    
    var method: Moya.Method {
        return .delete
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .removeAccount(let body):
            param.updateValue(body.reason, forKey: "reason")
            param.updateValue(body.content, forKey: "content")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
}
