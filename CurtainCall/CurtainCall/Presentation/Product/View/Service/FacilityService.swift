//
//  FacilityService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

import Combine
import Moya
import CombineMoya
import SwiftKeychainWrapper

enum FacilityService {
    case detail(id: String)
    case same(id: String)
}

extension FacilityService: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .detail(let id):
            return "/facilities/\(id)"
        case .same(let id):
            return "/facilities/\(id)/shows"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .detail:
            return .requestPlain
        case .same:
            var param: [String: Any] = [:]
            param.updateValue(99, forKey: "size")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
        
    }
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
}
