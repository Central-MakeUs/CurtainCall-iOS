//
//  ImageService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation

import Moya
import Combine
import CombineMoya
import SwiftKeychainWrapper

enum ImageAPI {
    case request(image: Data)
}

extension ImageAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        return "/images"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .request(let image):
            
            let formData = [MultipartFormData(provider: .data(image), name: "image", fileName: "\(UUID().uuidString).jpg", mimeType: "image/jpeg")]
            
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        let accessToken = KeychainWrapper.standard.string(forKey: .accessToken) ?? ""
        header.updateValue("Bearer \(accessToken)", forKey: "Authorization")
        header.updateValue("multipart/form-data", forKey: "Content-type")
        return header
    }
    
    
}

struct UploadImageResponse: Decodable {
    let id: Int
}
