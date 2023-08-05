//
//  APIService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import Foundation
import Alamofire
import Combine

final class APIService {
    static func request<T>(_ resource: APIResource<T>) ->  AnyPublisher<T, AFError> {
        return AF.request(resource.urlRequest!)
            .publishDecodable(type: T.self)
            .value()
            .eraseToAnyPublisher()
    }
}

struct Test: Decodable {
    let results: [AAA]
}

struct AAA: Decodable {
    let email: String
}
