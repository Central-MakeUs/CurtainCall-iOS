//
//  ReviewAPI.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/17.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum ReviewAPI {
    case create(id: String, grade: Int, content: String)
    case list(id: String, page: Int, size: Int)
    case update(id: String, grade: Int, content: String)
    case delete(id: String)
    case like(id: Int)
    case unLike(id: Int)
    case likeSearch(id: [Int])
}

extension ReviewAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .create(let id, _, _):
            return "/shows/\(id)/reviews"
        case .list(let id, _, _):
            return "/shows/\(id)/reviews"
        case .update(let id, _, _):
            return "/reviews/\(id)"
        case .delete(let id):
            return "/reviews/\(id)"
        case .like(let id):
            return "/reviews/\(id)/like"
        case .unLike(let id):
            return "/reviews/\(id)/like"
        case .likeSearch:
            return "/member/like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .list:
            return .get
        case .update:
            return .patch
        case .delete:
            return .delete
        case .like:
            return .put
        case .unLike:
            return .delete
        case .likeSearch:
            return .get
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .create(_, let grade, let content):
            param.updateValue(grade, forKey: "grade")
            param.updateValue(content, forKey: "content")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .list(_, let page, let size):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            return .requestPlain
        case .update(_, let grade, let content):
            param.updateValue(grade, forKey: "grade")
            param.updateValue(content, forKey: "content")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .delete:
            return .requestPlain
        case .like:
            return .requestPlain
        case .unLike:
            return .requestPlain
        case .likeSearch(let id):
            var param: [String: Any] = [:]
            param.updateValue(id, forKey: "reviewIds")
            return .requestParameters(
                parameters: param,
                encoding: URLEncoding(arrayEncoding: .noBrackets)
            )
        }
        
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
}
