//
//  MyPageService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation

import Moya
import CombineMoya
import SwiftKeychainWrapper

enum MyPageAPI {
    case detailProfile(id: Int)
    case updateProfile(body: UpdateMyPageBody)
    case recruitments(id: Int, page: Int, size: Int, category: PartyCategoryType?)
    case participations(id: Int, page: Int, size: Int, category: PartyCategoryType?)
    case myWriteReview
    case myWriteLostItem
}

extension MyPageAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .detailProfile(let id):
            return "/members/\(id)"
        case .updateProfile:
            return "/member"
        case .recruitments(let id, _, _, _):
            return "/members/\(id)/recruitments"
        case .participations(let id, _, _, _):
            return "/members/\(id)/participations"
        case .myWriteReview:
            return "/member/reviews"
        case .myWriteLostItem:
            return "/member/lostItems"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .detailProfile:
            return .get
        case .updateProfile:
            return .patch
        case .recruitments:
            return .get
        case .participations:
            return .get
        case .myWriteReview:
            return .get
        case .myWriteLostItem:
            return .get
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .detailProfile:
            return .requestPlain
        case .updateProfile(let body):
            param.updateValue(body.nickname, forKey: "nickname")
            if let imageId = body.imageId {
                param.updateValue(imageId, forKey: "imageId")
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .recruitments(_, let page, let size, let category):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            if let category { param.updateValue(category.rawValue, forKey: "category") }
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .participations(_, let page, let size, let category):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            if let category { param.updateValue(category.rawValue, forKey: "category") }
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .myWriteReview:
            param.updateValue(0, forKey: "page")
            param.updateValue(100, forKey: "size")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .myWriteLostItem:
            param.updateValue(0, forKey: "page")
            param.updateValue(100, forKey: "size")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
}
