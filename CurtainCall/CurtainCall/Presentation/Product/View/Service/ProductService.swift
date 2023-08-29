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
    case list(page: Int, size: Int, genre: ProductListAPI, sortedBy: ProductSortType?)
    case detail(id: String)
    case ticketking
    case search(page: Int, size: Int, keyword: String)
}

extension ProductAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .list: return "/shows"
        case .detail(let id): return "/shows/\(id)"
        case .ticketking: return ""
        case .search:
            return "/search/shows"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .list(let page, let size, let genre, let sort):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(genre.APIName, forKey: "genre")
            if let sort {
                param.updateValue(sort.APIName, forKey: "sort")
            }
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .detail:
            return .requestPlain
        case .ticketking:
            return .requestPlain
        case .search(let page, let size, let keyword):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(keyword, forKey: "keyword")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
}
