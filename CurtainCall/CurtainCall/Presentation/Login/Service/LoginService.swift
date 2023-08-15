//
//  LoginService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/13.
//

import Foundation
import Moya

enum LoginAPI {
    case kakao(String)
}

extension LoginAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .kakao:
            return "/login/oauth2/token/kakao"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .kakao:
            return .post
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .kakao(let token):
            param.updateValue(token, forKey: "accessToken")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
