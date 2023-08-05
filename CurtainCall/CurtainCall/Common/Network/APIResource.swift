//
//  APIResource.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/05.
//

import Foundation

struct APIResource<T: Decodable> {
    var base: String
    var path: String
    var params: [String: String]
    var header: [String: String]
    
    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: base + path),
              let url = urlComponents.url else { return nil }
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: url)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    init(base: String, path: String, params: [String: String] = [:], header: [String: String] = [:]) {
        self.base = base
        self.path = path
        self.params = params
        self.header = header
    }
}
