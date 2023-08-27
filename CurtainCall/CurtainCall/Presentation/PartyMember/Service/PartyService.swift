//
//  PartyService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/23.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum PartyAPI {
    case list(page: Int, size: Int, category: PartyCategoryType)
    case search(page: Int, size: Int, category: PartyCategoryType, keyword: String)
    case detail(id: Int)
    case create(body: CreatePartyBody)
    case delete(id: Int)
    case update(id: Int, title: String, content: String)
    case participation(id: Int)
}

extension PartyAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .list:
            return "/parties"
        case .search:
            return "/search/party"
        case .detail(let id):
            return "/parties/\(id)"
        case .create:
            return "/parties"
        case .delete(let id):
            return "/parties/\(id)"
        case .update(let id, _, _):
            return "/parties/\(id)"
        case .participation(let id):
            return "/member/parties/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
        case .create:
            return .post
        case .delete:
            return .delete
        case .update:
            return .patch
        case .participation:
            return .put
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .list(let page, let size, let category):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(category.rawValue, forKey: "category")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .search(let page, let size, let category, let keyword):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(category.rawValue, forKey: "category")
            param.updateValue(keyword, forKey: "keyword")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .detail:
            return .requestPlain
        case .create(let body):
            if body.category == "ETC" {
                if let showAt = body.showAt {
                    param.updateValue(showAt, forKey: "showAt")
                }
                
            } else {
                param.updateValue(body.showId ?? "", forKey: "showId")
                param.updateValue(body.showAt ?? "", forKey: "showAt")
            }
            param.updateValue(body.title, forKey: "title")
            param.updateValue(body.content, forKey: "content")
            param.updateValue(body.maxMemberNum, forKey: "maxMemberNum")
            param.updateValue(body.category, forKey: "category")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .delete:
            return .requestPlain
        case .update(_ , let title, let content):
            param.updateValue(title, forKey: "title")
            param.updateValue(content, forKey: "content")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .participation:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
}
