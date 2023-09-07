//
//  LiveTalkService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/07.
//

import Foundation
import Combine

import CombineMoya
import Moya
import SwiftKeychainWrapper

enum LiveTalkService {
    case show(page: Int, size: Int, showAt: String, showEndAt: String)
}

extension LiveTalkService: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .show: return "/show-times"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .show: return .get
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .show(let page, let size, let showAt, let showEndAt):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(showAt, forKey: "showAt")
            param.updateValue(showEndAt, forKey: "showEndAt")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
}
