//
//  ProductSearchViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/28.
//

import Foundation

import Moya
import CombineMoya
import Combine

final class ProductSearchViewModel {
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<ProductAPI>()
    @Published var productList: [ProductListContent] = []
    var page: Int = 0
    
    func requestSearch(page: Int, size: Int, keyword: String) {
        provider.requestPublisher(.search(page: page, size: size, keyword: keyword))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(ProductListResponse.self) {
                    self?.productList = data.content
                }
                print("##SEARCH", String(data: response.data, encoding: .utf8))
            }.store(in: &subscriptions)

    }
}
