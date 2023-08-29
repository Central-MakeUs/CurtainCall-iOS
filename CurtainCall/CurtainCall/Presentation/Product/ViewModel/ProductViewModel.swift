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
    var tempPlayList: [ProductListContent] = []
    var tempMusicalList: [ProductListContent] = []
    var isLoding = false
    var theaterPage: Int = 0
    var musicalPage: Int = 0
    
    func requestShow(page: Int, size: Int, genre: ProductListAPI, sort: ProductSortType) {
        provider.requestPublisher(.list(page: page, size: size, genre: genre, sortedBy: sort))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(ProductListResponse.self) {
                    requestFavorites(id: data.content.map { $0.id }, genre: genre)
                    if genre == .play {
                        if page == 0 {
                            tempPlayList = data.content
                        } else {
                            tempPlayList.append(contentsOf: data.content)
                        }
                    } else {
                        if page == 0 {
                            tempMusicalList = data.content
                        } else {
                            tempMusicalList.append(contentsOf: data.content)
                        }
                    }
                } else {
                    print("## RequestShow Decoding Error##")
                }
            }.store(in: &subscriptions)

    }
    
    
    func requestFavorites(id: [String], genre: ProductListAPI) {
        let provider = MoyaProvider<FavoriteShowAPI>()
        provider.requestPublisher(.getShowList(id: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(IsFavoriteResponse.self) {
                    data.content.filter { $0.favorite }.forEach {
                        FavoriteService.shared.isFavoriteIds.insert($0.showId)
                    }
                }
                if genre == .play {
                    playList = tempPlayList} else {
                        musicalList = tempMusicalList
                    }
            }.store(in: &subscriptions)

    }
}
