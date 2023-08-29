//
//  ReportService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/27.
//

import Foundation

import Moya
import CombineMoya
import SwiftKeychainWrapper

enum ReportAPI {
    case party(body: PartyReportBody)
}

extension ReportAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .party:
            return "/reports"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .party: return .post
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .party(let body):
            param.updateValue(body.idToReport, forKey: "idToReport")
            param.updateValue(body.reason.rawValue, forKey: "reason")
            param.updateValue(body.content, forKey: "content")
            param.updateValue(body.type.rawValue, forKey: "type")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
    
}

struct PartyReportBody: Encodable {
    let idToReport: Int
    let type: ReportAPIType
    let reason: ReportType
    let content: String
}

enum ReportType: String, CaseIterable, Encodable {
    case spam = "SPAM"
    case hateSpeech = "HATE_SPEECH"
    case iliegal = "ILLEGAL"
    case badManners = "BAD_MANNERS"
    case teenager = "HARMFUL_TO_TEENAGER"
    case personalInformationDisclosure = "PERSONAL_INFORMATION_DISCLOSURE"
    case etc = "ETC"
}

enum ReportAPIType: String, Encodable {
    case party = "PARTY"
    case review = "SHOW_REVIEW"
    case lostItem = "LOST_ITEM"
}
