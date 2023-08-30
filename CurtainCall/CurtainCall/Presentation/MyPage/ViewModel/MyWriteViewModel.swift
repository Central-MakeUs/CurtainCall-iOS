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

final class MyWriteViewModel {
    
    private let provider = MoyaProvider<FavoriteShowAPI>()
    private let id: Int
    private var subscriptions: Set<AnyCancellable> = []
    var myShowList = CurrentValueSubject<[MyFavoriteShowContent], Error>([])
    
    init(id: Int) {
        self.id = id
    }
    
    func requestMyWrite() {
        provider.requestPublisher(.getMyFavoriteShow(memberId: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(MyFavoriteShowResponse.self) {
                    self?.myShowList.send(data.content)
                } else {
                    self?.myShowList.send(completion: .failure(NSError(domain: "Decoding Error", code: 999)))
                }
            }.store(in: &subscriptions)

    }
}

struct MyFavoriteShowResponse: Decodable {
    let content: [MyFavoriteShowContent]
}

struct MyFavoriteShowContent: Decodable {
    let id: String
    let name: String
    let poster: String
    let story: String
    let reviewCount: Double
    let reviewGradeSum: Double
}
