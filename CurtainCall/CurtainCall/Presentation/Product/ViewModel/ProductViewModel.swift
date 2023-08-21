//
//  ProductViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/21.
//

import Foundation

import Moya
import CombineMoya
import Combine

final class ProductViewModel {
    
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<ProductAPI>()
    @Published var playList: [ProductListContent] = []
    @Published var musicalList: [ProductListContent] = []
    
    func requestShow(page: Int, size: Int, genre: ProductListAPI) {
        provider.requestPublisher(.list(page: page, size: size, genre: genre))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(ProductListResponse.self) {
                    if genre == .play {
                        if page == 0 {
                            playList = data.content
                        } else {
                            playList.append(contentsOf: data.content)
                        }
                    } else {
                        if page == 0 {
                            musicalList = data.content
                        } else {
                            musicalList.append(contentsOf: data.content)
                        }
                    }
                }
            }.store(in: &subscriptions)

    }
}
