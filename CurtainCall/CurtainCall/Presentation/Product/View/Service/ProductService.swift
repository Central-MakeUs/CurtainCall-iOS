//
//  ProductService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/17.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum ProductListAPI {
    case play
    case musical
    
    var APIName: String {
        switch self {
        case .play:
            return "PLAY"
        case .musical:
            return "MUSICAL"
        }
    }
}

enum ProductAPI {
    case list(page: Int, size: Int, genre: ProductListAPI)
    case detail(id: String)
    case ticketking
}

extension ProductAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .list: return "/shows"
        case .detail(let id): return "/shows/\(id)"
        case .ticketking: return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .list(let page, let size, let genre):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(genre.APIName, forKey: "genre")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .detail:
            return .requestPlain
        case .ticketking:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
}
