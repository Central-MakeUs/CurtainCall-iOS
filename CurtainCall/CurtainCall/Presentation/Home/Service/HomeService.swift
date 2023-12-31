//
//  HomeService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation
import Combine

import CombineMoya
import Moya
import SwiftKeychainWrapper

enum HomeAPI {
    case open(page: Int, size: Int, startDate: String)
    case top10(type: String, genre: String, baseDate: String)
    case end(page: Int, size: Int, endDate: String, genre: String)
}

extension HomeAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .open:
            return "/shows-to-open"
        case .top10:
            return "/box-office"
        case .end:
            return "/shows-to-end"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .open(let page, let size, let startDate):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(startDate, forKey: "startDate")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .top10(let type, let genre, let baseDate):
            param.updateValue(type, forKey: "type")
            param.updateValue(genre, forKey: "genre")
            param.updateValue(baseDate, forKey: "baseDate")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .end(let page, let size, let endDate, let genre):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(endDate, forKey: "endDate")
            param.updateValue(genre, forKey: "genre")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
    
}
