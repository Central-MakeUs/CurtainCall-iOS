//
//  FavoriteShowService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/22.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum FavoriteShowAPI {
    case putShow(id: String)
    case deleteShow(id: String)
    case getShowList(id: [String])
    case getMyFavoriteShow(memberId: Int)
    
}

extension FavoriteShowAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .putShow(let id):
            return "/shows/\(id)/favorite"
        case .deleteShow(let id):
            return "/shows/\(id)/favorite"
        case .getShowList:
            return "/member/favorite"
        case .getMyFavoriteShow(let memerId):
            return "/members/\(memerId)/favorite"
        }
    }
    var method: Moya.Method {
        switch self {
        case .putShow: return .put
        case .deleteShow: return .delete
        case .getShowList: return .get
        case .getMyFavoriteShow: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .putShow:
            return .requestPlain
        case .deleteShow:
            return .requestPlain
        case .getShowList(let id):
            var param: [String: Any] = [:]
            param.updateValue(id, forKey: "showIds")
            return .requestParameters(
                parameters: param,
                encoding: URLEncoding(arrayEncoding: .noBrackets)
            )
        case .getMyFavoriteShow:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
}
