//
//  NoticeService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum NoticeAPI {
    case basic(Int, Int)
    case detail(Int)
}

extension NoticeAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .basic:
            return "/notices"
        case .detail(let id):
            return "/notices/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .basic(let page, let size):
            var param: [String: Any] = [:]
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .detail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
}
