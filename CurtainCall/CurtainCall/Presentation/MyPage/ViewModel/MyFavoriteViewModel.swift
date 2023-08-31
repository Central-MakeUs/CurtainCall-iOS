//
//  MyWriteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/30.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class MyFavoriteViewModel {
    
    private let provider = MoyaProvider<FavoriteShowAPI>()
    private let id: Int
    private var subscriptions: Set<AnyCancellable> = []
    var myFavoriteShowList = CurrentValueSubject<[ProductListContent], Error>([])
    
    init(id: Int) {
        self.id = id
    }
    
    func requestMyFavorite() {
        provider.requestPublisher(.getMyFavoriteShow(memberId: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                print("####", String(data: response.data, encoding: .utf8))
                if let data = try? response.map(ProductListResponse.self) {
                    self?.myFavoriteShowList.send(data.content)
                } else {
                    self?.myFavoriteShowList.send(completion: .failure(NSError(domain: "Decoding Error", code: 999)))
                }
            }.store(in: &subscriptions)

    }
}

//struct MyFavoriteShowResponse: Decodable {
//    let content: [MyFavoriteShowContent]
//}
//
//struct MyFavoriteShowContent: Hashable, Decodable {
//    let id: String
//    let name: String
//    let poster: String
//    let story: String
//    let reviewCount: Double
//    let reviewGradeSum: Double
//}
