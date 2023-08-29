//
//  PartySearchViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/29.
//

import Foundation
import Combine

import Moya
import CombineMoya

final class PartySearchViewModel {
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<PartyAPI>()
    @Published var partyList: [PartyListContent] = []
    private let partyType: PartyCategoryType
    var page = 0
    var isLoding = false
    
    init(partyType: PartyCategoryType) {
        self.partyType = partyType
    }
    
    func requestSearch(page: Int, size: Int, keyword: String) {
        provider.requestPublisher(.search(page: page, size: size, category: partyType, keyword: keyword))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(PartyListResponse.self) {
                    if page == 0 {
                        self?.partyList = data.content
                    } else {
                        self?.partyList.append(contentsOf: data.content)
                    }
                }
            }.store(in: &subscriptions)
    }
}
