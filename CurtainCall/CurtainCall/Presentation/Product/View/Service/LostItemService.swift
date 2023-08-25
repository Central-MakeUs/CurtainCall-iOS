//
//  LostItemService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper

enum LostType: String {
    case BAG, WALLET, CASH, CARD, JEWELRY, ELECTRONIC_EQUIPMENT, BOOK, CLOTHING, ETC
}

enum LostItemService {
    case create(body: CreateLostItemBody)
    case list(page: Int, size: Int, id: Int, type: LostType, date: String, title: String)
    case detail(id: Int)
    case delete(id: Int)
    case update(id: Int, body: CreateLostItemBody)
}

extension LostItemService: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .create:
            return "/lostItems"
        case .list:
            return "/lostItems"
        case .detail(let id):
            return "/lostItems/\(id)"
        case .delete(let id):
            return "/lostItems/\(id)"
        case .update(let id, _):
            return "/lostItems/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .list:
            return .get
        case .detail:
            return .get
        case .delete:
            return .delete
        case .update:
            return .patch
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .create(let body):
            param.updateValue(body.title, forKey: "title")
            param.updateValue(body.type, forKey: "type")
            param.updateValue(body.facilityId, forKey: "facilityId")
            if let foundPlaceDetail = body.foundPlaceDetail {
                param.updateValue(foundPlaceDetail, forKey: "foundPlaceDetail")
            }
            param.updateValue(body.foundDate, forKey: "foundDate")
            if let foundTime = body.foundTime {
                param.updateValue(foundTime, forKey: "foundTime")
            }
            param.updateValue(body.particulars, forKey: "particulars")
            param.updateValue(body.imageId, forKey: "imageId")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .list(let page, let size, let id, let type, let date, let title):
            param.updateValue(page, forKey: "page")
            param.updateValue(size, forKey: "size")
            param.updateValue(id, forKey: "id")
            param.updateValue(type, forKey: "type")
            param.updateValue(date, forKey: "date")
            param.updateValue(title, forKey: "title")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .detail:
            return .requestPlain
        case .delete:
            return .requestPlain
        case .update(_, let body):
            param.updateValue(body.title, forKey: "title")
            param.updateValue(body.type, forKey: "type")
            param.updateValue(body.facilityId, forKey: "facilityId")
            if let foundPlaceDetail = body.foundPlaceDetail {
                param.updateValue(foundPlaceDetail, forKey: "foundPlaceDetail")
            }
            param.updateValue(body.foundDate, forKey: "foundDate")
            if let foundTime = body.foundTime {
                param.updateValue(foundTime, forKey: "foundTime")
            }
            param.updateValue(body.particulars, forKey: "particulars")
            param.updateValue(body.imageId, forKey: "imageId")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
    
}
